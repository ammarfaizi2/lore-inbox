Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbQLANee>; Fri, 1 Dec 2000 08:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbQLANeP>; Fri, 1 Dec 2000 08:34:15 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9546 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129255AbQLANdk>; Fri, 1 Dec 2000 08:33:40 -0500
Subject: Re: [PATCH] i810_audio 2.4.0-test11
To: tjeerd.mulder@fujitsu-siemens.com (Tjeerd Mulder)
Date: Fri, 1 Dec 2000 13:02:39 +0000 (GMT)
Cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
In-Reply-To: <3A278916.6FF0C5DE@fujitsu-siemens.com> from "Tjeerd Mulder" at Dec 01, 2000 12:18:46 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E141ppq-0000DP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It implements mono output and fixes a bug in the dma logic (reset necessary 
> because some descriptors are already prefetched and are not updated

This is wrong. Linus please do not apply this patch, or if you have done back
it out. Not only does it do format conversions in kernel (which is a strict
not to be done in the sound driver policy) it also makes it impossible to make
mmap work correctly with the OSS API definitions.

Tjeerd. I deliberately applied only small bits of your patch before because
the mono mode stuff clutters the driver horribly and is not in the right place.
It belongs in the application/libraries

Alan


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
