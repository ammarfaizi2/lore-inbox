Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285466AbRLGLlF>; Fri, 7 Dec 2001 06:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285467AbRLGLkw>; Fri, 7 Dec 2001 06:40:52 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:36804 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S285466AbRLGLkm>; Fri, 7 Dec 2001 06:40:42 -0500
Date: Fri, 7 Dec 2001 12:40:37 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Falk Stern <f.stern@mobile.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre6 compilation errors
In-Reply-To: <1007722632.1870.0.camel@station45>
Message-ID: <Pine.NEB.4.43.0112071237020.726-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Dec 2001, Falk Stern wrote:

> Hi.

Hi Falk,

> Just tried to compile a vanilla 2.5.1-pre6 and got following errors:
> (while doing "make dep clean bzImage modules modules_install" )
>...
> drivers/char/char.o(.data+0x46b4): undefined reference to `local symbols
> in discarded section .text.exit'
> drivers/net/net.o(.data+0xd4): undefined reference to `local symbols in
> discarded section .text.exit'
> make: *** [vmlinux] Error 1
>...
> # ld -V
> GNU ld version 2.11.92.0.12.3 20011121 Debian/GNU Linux
>...

this is a known bug in the kernel that shows up with the latest binutils
packages in Debian unstable. As a workaround you can downgrade your
binutils to the 2.11.92.0.10-4 package in Debian testing (you can
download it from [1] if don't have it any more).

cu
Adrian

[1] ftp://ftp.de.debian.org/debian/pool/main/b/binutils/

-- 

Get my GPG key: finger bunk@debian.org | gpg --import

Fingerprint: B29C E71E FE19 6755 5C8A  84D4 99FC EA98 4F12 B400

