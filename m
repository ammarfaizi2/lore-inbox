Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262535AbUCJASX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 19:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbUCJASW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 19:18:22 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:11200 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262535AbUCJAST convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 19:18:19 -0500
From: "Ingo at Pyrillion" <ingo@pyrillion.org>
To: "'Norberto Bensa'" <norberto+linux-kernel@bensa.ath.cx>
Cc: <linux-kernel@vger.kernel.org>
Subject: AW: Kernel 2.6.3 patch for Intel Compiler 8.0
Date: Wed, 10 Mar 2004 01:18:03 +0100
Message-ID: <000001c40635$2d4841c0$374ca8c0@bunnybook2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
In-Reply-To: <200403092108.31922.norberto+linux-kernel@bensa.ath.cx>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:c4c36d513a3e07b982252e2b8ea3678d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I used the patch to compile two identical kernels with gcc 3.3.3 and
icc 8.0 with oprofile support built in.
The optimization switches were chosen quite conservative, i.e.
"-O2 -Ob1", no IPO, and of course: no MMX, SSE, and SSE2 stuff inside
the kernel (thus disabling Intel's great vectorizer).
Profiling: lmbench ran ten times but time measurements were taken from
oprofile (on Pentium 4, GLOBAL_POWER_EVENTS in kernel space only, 
counter overflow: 3.000).
Results: 33% of the lmbench procs faster on icc, 66% faster on gcc.

Thus, take the kernel patch as a good basis for modifying the 
compiler switches and other things to get more performance gains. As
I know, a lot of people are looking for a patch.

Please check the patch file; you have to modify a lot of things in 2.6.3
to create a quite stable working version of the kernel. The patch is not
just about changing some minor Makefile things...

Kind rgs., Ingo.

-----Ursprüngliche Nachricht-----
Von: Norberto Bensa [mailto:norberto+linux-kernel@bensa.ath.cx] 
Gesendet: Mittwoch, 10. März 2004 01:09
An: Ingo at Pyrillion
Cc: linux-kernel@vger.kernel.org
Betreff: Re: Kernel 2.6.3 patch for Intel Compiler 8.0


Ingo at Pyrillion wrote:
> patch to compile the kernel with Intel Compiler 8.0
> for Linux.

Speed improvements over same kernel compiled with gcc?

Thanks,
Norberto

