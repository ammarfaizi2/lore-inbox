Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261948AbVGKPMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbVGKPMH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 11:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbVGKPKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 11:10:05 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:56821 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261939AbVGKPGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 11:06:52 -0400
Message-ID: <5489525.1121093570272.SLOX.WebMail.wwwrun@exchange.deltacomputer.de>
Date: Mon, 11 Jul 2005 16:52:50 +0200 (CEST)
From: Oliver Weihe <o.weihe@deltacomputer.de>
To: linux-kernel@vger.kernel.org
Subject: Problems with more than 8 AMD Opteron Cores per System
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Priority: 3 (normal)
X-Mailer: SuSE Linux Openexchange Server 4 - WebMail (Build 2.3826)
X-Operating-System: Linux 2.4.21-241-smp i386 (JVM 1.3.1_04)
Organization: Delta Computer Products GmbH
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:62e2eaa30f0557f14c09a5fa777a0a78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've two Iwill 8way Opteron equipped with 8 Opteron 875 CPUs each.
(In the past we build some systems with singlecore CPUs and they went
very well)

The Problem now is that the machines crash during boot when maxcpus is
greater than 8.
2.6.12-rc4 works well with maxcpus=8, with 9 or more it freezes after
"Testing NMI Watchdog... OK"

2.6.12-rc5 and above have more problems even with maxcpus=4 or less very
early during booting.

2.6.13-X crashes later during boot (from 2 to 16 cores it's the same
behavior)

The last I can so on the console (kernel 2.6.13-rc2-git4, maxcpus=2..16)
is:

NET: Registered protocol family 1
Using IPI Shortcut mode
int3: 0000 [1] SMP
CPU4
Modules linked in:
Freeing unused kernel memory: 212k freed
Pid: 0, comm: swapper Not tainted 2.6.13-rc2-git4-default
RIP: 0010:[<ffffffff8050fc00>]

After that the machines are totally freezed.

With maxcpus=1 all (tested) versions >=2.6.12-rc3 are able to boot.

Any hints/ideas/what ever?

Regards,
   Oliver Weihe

P.S. if you answer CC me ;)

