Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129426AbRBIViM>; Fri, 9 Feb 2001 16:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129576AbRBIViB>; Fri, 9 Feb 2001 16:38:01 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:44812 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129426AbRBIVht>;
	Fri, 9 Feb 2001 16:37:49 -0500
Message-ID: <3A846328.4DD7191@mandrakesoft.com>
Date: Fri, 09 Feb 2001 16:37:44 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Braun <braun@itwm.fhg.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: No sound on GA-7ZX (2.4.1-ac6, via audio)
In-Reply-To: <3A82F427.916F8F0C@itwm.fhg.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Braun wrote:
> I can not get sound working on a computer with a Gigabyte
> GA-7ZX mainboard (KT133 chipset). Is this a known problem?
> I have attached some config info. Mail me for further details.

Can you download and run via-audio-diag as described in the
documentation?  That will provide me with excellent debugging info. 
Also, define VIA_DEBUG at the top of the code, try to play something,
and let me know what the output in your kernel log (or from
/usr/bin/dmesg) says...

via-audio-diag is available in the via82cxxx_audio tarball posted at
http://sourceforge.net/projects/gkernel/


> $ lsmod
> Module                  Size  Used by
> via82cxxx_audio        27680   0
> ac97_codec              8720   0  [via82cxxx_audio]
> soundcore               4240   2  [via82cxxx_audio]

> 00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 [Apollo Super AC97/Audio] (rev 20)

You are definitely using the correct driver.  es13xx or whatever driver
won't work for this chipset.

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
