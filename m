Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282838AbRLGMNh>; Fri, 7 Dec 2001 07:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282839AbRLGMN2>; Fri, 7 Dec 2001 07:13:28 -0500
Received: from atm42.mobile.de ([212.12.52.53]:61194 "EHLO ATM42.mobile.de")
	by vger.kernel.org with ESMTP id <S282838AbRLGMNK> convert rfc822-to-8bit;
	Fri, 7 Dec 2001 07:13:10 -0500
Subject: Re: 2.5.1-pre6 compilation errors
From: Falk Stern <f.stern@mobile.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.NEB.4.43.0112071237020.726-100000@mimas.fachschaften.tu-muenchen.de>
In-Reply-To: <Pine.NEB.4.43.0112071237020.726-100000@mimas.fachschaften.tu-muenchen.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 07 Dec 2001 12:59:57 +0100
Message-Id: <1007726397.16834.2.camel@ridcully>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-12-07 at 12:40, Adrian Bunk wrote:
> On 7 Dec 2001, Falk Stern wrote:
> > Just tried to compile a vanilla 2.5.1-pre6 and got following errors:
> > (while doing "make dep clean bzImage modules modules_install" )
> >...
> > drivers/char/char.o(.data+0x46b4): undefined reference to `local symbols
> > in discarded section .text.exit'
> > drivers/net/net.o(.data+0xd4): undefined reference to `local symbols in
> > discarded section .text.exit'
> > make: *** [vmlinux] Error 1
> >...
> > # ld -V
> > GNU ld version 2.11.92.0.12.3 20011121 Debian/GNU Linux
> >...
> 
> this is a known bug in the kernel that shows up with the latest binutils
> packages in Debian unstable. As a workaround you can downgrade your
> binutils to the 2.11.92.0.10-4 package in Debian testing (you can
> download it from [1] if don't have it any more).

ok, "apt-get install binutils=2.11.92.0.10-4" did the job.

Thanks a lot

Falk

-- 
Mit freundlichen Grüßen
Ihr mobile.de Team

Falk Stern
Technik - Systemadministration

mobile.de GmbH
Bueschstr. 7 - D-20354 Hamburg
Tel.: +49 (0) 40/879 77-414
Fax:  +49 (0) 40/43 18 23-55
Web: http://www.mobile.de

