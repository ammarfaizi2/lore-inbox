Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129854AbRCTMIE>; Tue, 20 Mar 2001 07:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130038AbRCTMHy>; Tue, 20 Mar 2001 07:07:54 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:36232 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S129854AbRCTMHh>;
	Tue, 20 Mar 2001 07:07:37 -0500
Message-ID: <3AB747BB.73F041CE@mandrakesoft.com>
Date: Tue, 20 Mar 2001 07:06:19 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alessandro Suardi <alessandro.suardi@oracle.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk
Subject: Re: PCMCIA serial CardBus support vanished in 2.4.3-pre3 and later
In-Reply-To: <3AB732F0.CE13E52F@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Suardi wrote:
> 
> Sorry to repost the issue but I got no reply...
> 
>  2.4.3-pre3 and synced-up versions of the -ac series remove support for
>  PCMCIA serial CardBus. In drivers/char/pcmcia the Makefile and Config.in
>  files are modified to exclude serial_cb and the serial_cb.c file itself
>  is removed by the patch. As a net result, my Xircom modem port becomes
>  invisible to the kernel and I can't dial out through it.
> 
> As a temporary measure I backed out the changes in drivers/char/pcmcia
>  and my 2.4.3-pre4 kernel seems happy (in fact I am dialing out through
>  said Xircom modem).
> 
> Did I miss some announcement for replacement features for serial_cb or
>  did a bad patch slip in ?

Neither.  serial.c does serial_cb's job now.  It looks like serial.c
needs to scan for modems as well as serial ports, and tytso agrees with
me on that.  We just need to check and see if winmodems reports
themselves as real modems before fixing this.

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full mooon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
