Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317779AbSGKHRL>; Thu, 11 Jul 2002 03:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317780AbSGKHRK>; Thu, 11 Jul 2002 03:17:10 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:56998 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S317779AbSGKHRC>;
	Thu, 11 Jul 2002 03:17:02 -0400
Message-ID: <002601c228ab$86b235e0$1c6fa8c0@hyper>
From: "Christian Ludwig" <cl81@gmx.net>
To: "Ville Herva" <vherva@niksula.hut.fi>
Cc: "Linux Kernel Mailinglist" <linux-kernel@vger.kernel.org>
References: <003d01c22819$ba1818b0$1c6fa8c0@hyper> <20020711062832.GU1548@niksula.cs.hut.fi>
Subject: Re: bzip2 support against 2.4.18
Date: Thu, 11 Jul 2002 09:21:07 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I actually did not mesásured how much smaller bz2bzImages are definitely.
Want to say that I haven't made a complete battery of tests yet.

The only thing I found out empirically is that my boot+root floppy (2MB
ext2fs root, totally overcrowded of course ;( and with kernel/ramdisk dd'ed
straight on it without lilo) is about 1.42MB with the standard 2.4.18 kernel
alltogether. Using bz2bzImage and compressing the root image with bzip -9
the overall size went down to 1.3MB with exactly the same configuration.

I also have tested it with a 4MB RAM 486DX-100 PC, but this crashed after
loading the kernel, so the decompression failed.
Putting in another 4MB into that machine (thus it has 8MB now), made the
kernel boot, but ramdisk decompression failed. All in all you will need at
least 12MB to boot correctly, if you are using a bz2bzImage of about 700kB
and a 2MB compressed ramdisk image.
But I think nowadays ram shouldn't be that problem anymore, as log as we are
speaking of 12MB. For anybody who does not have that "much" ram the old
method is still available...

Have fun...

    - Christian

---------------------------------
Computers get faster every day.
Linux gets better every day.
I won't use Windows in no way.


