Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129440AbRCLDUL>; Sun, 11 Mar 2001 22:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129443AbRCLDTw>; Sun, 11 Mar 2001 22:19:52 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:61873 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S129440AbRCLDTc>;
	Sun, 11 Mar 2001 22:19:32 -0500
Message-ID: <3AAC3FFA.1C3DDC0E@mandrakesoft.com>
Date: Sun, 11 Mar 2001 22:18:18 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Bombe <andreas.bombe@munich.netsurf.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hotplug and interrupt context
In-Reply-To: <20010312014811.B472@storm.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Bombe wrote:
> 
> I couldn't trace that down to be 100% sure and it's better to conform to
> design than implementation, so I'll ask:
> 
> Do the probe and remove functions of a pci_driver have to be able to
> work in interrupt context?  (i.e. GFP_ATOMIC and stuff)

No, no interrupt context to worry about.  It would really suck if you
couldn't sleep in pci_driver::probe :)

For CardBus, it calls schedule_task ..

-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
