Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbUEOMnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUEOMnD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 08:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbUEOMnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 08:43:03 -0400
Received: from alsvidh.mathematik.uni-muenchen.de ([129.187.111.42]:128 "EHLO
	sleipnir.theorie.physik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S262279AbUEOMnA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 08:43:00 -0400
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] ext3 and other filesystem drivers on powerpc
Organization: Lehrstuhl fuer vergleichende Astrozoologie
X-Mahlzeit: Das ist per Saldo Gemuetlichkeit
Reply-To: Jens Schmalzing <j.s@lmu.de>
From: Jens Schmalzing <j.s@lmu.de>
Date: 15 May 2004 12:31:52 +0200
Message-ID: <hhr7tmq8vb.fsf@theorie.physik.uni-muenchen.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

apparently, a couple of filesystem drivers do not work on powerpc if
built as modules.  Since ext3 is one of them, this bug is quite a
showstopper.  The following trivial patch provides a fix.

Regards, Jens.

--- kernel-source-2.6.6/arch/ppc/kernel/ppc_ksyms.c	2004-04-05 11:49:23.000000000 +0200
+++ kernel-source-2.6.6/arch/ppc/kernel/ppc_ksyms.c	2004-05-13 15:32:49.492035184 +0200
@@ -72,6 +72,7 @@
 
 extern unsigned long mm_ptov (unsigned long paddr);
 
+EXPORT_SYMBOL(clear_pages);
 EXPORT_SYMBOL(clear_page);
 EXPORT_SYMBOL(clear_user_page);
 EXPORT_SYMBOL(do_signal);


-- 
J'qbpbe, le m'en fquz pe j'qbpbe!
Le veux aimeb et mqubib panz je pézqbpbe je djuz tqtaj!
