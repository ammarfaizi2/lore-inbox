Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282164AbRKWPNR>; Fri, 23 Nov 2001 10:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282161AbRKWPNH>; Fri, 23 Nov 2001 10:13:07 -0500
Received: from hermes.domdv.de ([193.102.202.1]:25102 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S282165AbRKWPNC>;
	Fri, 23 Nov 2001 10:13:02 -0500
Message-ID: <XFMail.20011123161123.ast@domdv.de>
X-Mailer: XFMail 1.5.1 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.33.0111231546190.18284-100000@localhost.localdomain>
Date: Fri, 23 Nov 2001 16:11:23 +0100 (CET)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: RE: [bug] broken loopback fs in 2.4.15-ish kernels?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did experiment with romfs on 2.4.15pre7 which did not work (initrd loader
detected romfs, I could loop mount it but the kernel didn't root mount it).
Funny enough using ext2 did work as expected. Maybe there's a common reason.

On 23-Nov-2001 Ingo Molnar wrote:
> 
> just noticed that rpm -i kernel-2.4.9-13.i386.rpm does not work anymore
> because a corrupted initrd gets created by mkinitrd. It smelled like
> pagecache corruption so i did not experiment much. This was with
> 2.4.15-pre9. Once i booted back into a 2.4.13-based kernel and re-did the
> rpm -i, the initrd was created correctly.
> 
> things are pretty recent:
> 
>  [root@mars root]# rpm -q mkinitrd
>  mkinitrd-3.2.6-1
>  [root@mars root]# rpm -q rpm
>  rpm-4.0.3-1.03
> 
> anyone seeing anything similar?
> 
>       Ingo
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
