Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267927AbTBRRid>; Tue, 18 Feb 2003 12:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267929AbTBRRid>; Tue, 18 Feb 2003 12:38:33 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:24256 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267927AbTBRRic>; Tue, 18 Feb 2003 12:38:32 -0500
Date: Tue, 18 Feb 2003 11:48:15 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: "Robert P. J. Day" <rpjday@mindspring.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: why is "scripts/elfconfig.h" not removed with "make mrproper"?
In-Reply-To: <Pine.LNX.4.44.0302181059210.15334-100000@dell>
Message-ID: <Pine.LNX.4.44.0302181147460.24975-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2003, Robert P. J. Day wrote:

>   i just verified that the original 2.5.62 kernel tree does not
> start with the header file "scripts/elfconfig.h".  this file is
> created by running "make xconfig", even when nothing is configured.
> but that file is *not* removed by running "make mrproper", which
> i would think it should be.

Right.

--Kai


===== scripts/Makefile 1.30 vs edited =====
--- 1.30/scripts/Makefile	Sun Feb 16 21:20:26 2003
+++ edited/scripts/Makefile	Tue Feb 18 11:47:10 2003
@@ -17,6 +17,8 @@
 # Let clean descend into subdirs
 subdir-	:= lxdialog kconfig
 
+clean-files := elfconfig.h
+
 # fixdep is needed to compile other host programs
 $(addprefix $(obj)/,$(filter-out fixdep,$(build-targets))): $(obj)/fixdep
 

