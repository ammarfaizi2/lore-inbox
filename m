Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272000AbTG2TDo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 15:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272003AbTG2TDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 15:03:44 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:22792 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S272000AbTG2TDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 15:03:43 -0400
Date: Tue, 29 Jul 2003 21:03:40 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: 2.6.0-test2-mm1 and the mysterious dissapearing penguin..
Message-ID: <20030729190340.GA5791@mars.ravnborg.org>
Mail-Followup-To: Valdis.Kletnieks@vt.edu,
	linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
References: <200307281759.h6SHx75k004260@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307281759.h6SHx75k004260@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 01:59:07PM -0400, Valdis.Kletnieks@vt.edu wrote:
>   LD      arch/i386/kernel/built-in.o
> ./scripts/pnmtologo -t mono -n logo_linux_mono -o drivers/video/logo/logo_linux_mono.c drivers/video/logo/logo_linux_mono.pbm
>   CC      drivers/video/logo/logo_linux_mono.o
> ./scripts/pnmtologo -t vga16 -n logo_linux_vga16 -o drivers/video/logo/logo_linux_vga16.c drivers/video/logo/logo_linux_vga16.ppm
>   CC      drivers/video/logo/logo_linux_vga16.o
> ./scripts/pnmtologo -t clut224 -n logo_linux_clut224 -o drivers/video/logo/logo_linux_clut224.c drivers/video/logo/logo_linux_clut224.ppm
>   CC      drivers/video/logo/logo_linux_clut224.o
>   LD      drivers/video/logo/built-in.o
>   LD      drivers/video/built-in.o
>   LD      drivers/built-in.o
>   GEN     .version
>   CHK     include/linux/compile.h
> 
> Looks like a dependency issue?  Why would they get build THIS time and apparently
> not the first time around?

When building the logo stuff there is some dependencies missing in the
Makefile which causes what you see.
Kai G. has a fix pending in his tree for this, so expect that
bit to be sovled pretty soon.

	Sam
