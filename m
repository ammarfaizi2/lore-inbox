Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262619AbUCOQIu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 11:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262622AbUCOQIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 11:08:49 -0500
Received: from smtp-out.girce.epro.fr ([195.6.195.146]:12177 "EHLO
	srvsec1.girce.epro.fr") by vger.kernel.org with ESMTP
	id S262619AbUCOQIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 11:08:47 -0500
Message-ID: <036801c40aa7$06d40170$3cc8a8c0@epro.dom>
From: "Colin Leroy" <colin@colino.net>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: <benh@kernel.crashing.org>, <linux-kernel@vger.kernel.org>
References: <20040314225913.4654347b@jack.colino.net> <20040315155120.GA4342@smtp.west.cox.net> <035701c40aa5$1549b490$3cc8a8c0@epro.dom> <20040315160313.GB4342@smtp.west.cox.net>
Subject: Re: [PATCH] 2.6.4-bk3 ppc32 compile fix
Date: Mon, 15 Mar 2004 17:03:16 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0365_01C40AAF.687243D0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0365_01C40AAF.687243D0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi again,

> The problem is that on PPC32 (and probably sparc64) 'asmlinkage' is a
> useless keyword, and should just be removed from
> include/asm-ppc/unistd.h.

Here's another patch, then :)
(not changing sparc64 stuff... I can't test it)
-- 
Colin
------=_NextPart_000_0365_01C40AAF.687243D0
Content-Type: application/octet-stream;
	name="asmlinkage.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="asmlinkage.diff"

--- include/asm-ppc/unistd.h.orig	2004-03-11 03:55:23.000000000 +0100=0A=
+++ include/asm-ppc/unistd.h	2004-03-15 17:01:49.000000000 +0100=0A=
@@ -415,10 +415,10 @@=0A=
 int sys_pipe(int __user *fildes);=0A=
 int sys_ptrace(long request, long pid, long addr, long data);=0A=
 struct sigaction;=0A=
-asmlinkage long sys_rt_sigaction(int sig,=0A=
-				const struct sigaction __user *act,=0A=
-				struct sigaction __user *oact,=0A=
-				size_t sigsetsize);=0A=
+long sys_rt_sigaction(int sig,=0A=
+		      const struct sigaction __user *act,=0A=
+		      struct sigaction __user *oact,=0A=
+		      size_t sigsetsize);=0A=
 =0A=
 #endif /* __KERNEL_SYSCALLS__ */=0A=
 =0A=

------=_NextPart_000_0365_01C40AAF.687243D0--

