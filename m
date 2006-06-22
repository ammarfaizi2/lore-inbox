Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161167AbWFVQ0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161167AbWFVQ0l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 12:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161169AbWFVQ0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 12:26:40 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:10938 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1161167AbWFVQ0j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 12:26:39 -0400
Date: Thu, 22 Jun 2006 18:26:31 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: jdike@addtoit.com
Subject: UML compilation fails on JB_*
Message-ID: <Pine.LNX.4.61.0606221823040.21525@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-1692274460-1150993591=:21525"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-1692274460-1150993591=:21525
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,



Linux 2.6.17, in void get_thread_regs(union uml_pt_regs *uml_regs, void 
*buffer):

  CC      arch/um/os-Linux/sys-i386/registers.o
arch/um/os-Linux/sys-i386/registers.c: In function ■get_thread_regs■:
arch/um/os-Linux/sys-i386/registers.c:137: error: ■JB_PC■ undeclared (first 
use
in this function)
arch/um/os-Linux/sys-i386/registers.c:137: error: (Each undeclared 
identifier is reported only once
arch/um/os-Linux/sys-i386/registers.c:137: error: for each function it 
appears in.)
arch/um/os-Linux/sys-i386/registers.c:138: error: ■JB_SP■ undeclared (first 
use
in this function)
arch/um/os-Linux/sys-i386/registers.c:139: error: ■JB_BP■ undeclared (first 
use
in this function)


I have seen this before (while trying to cross-compile a sparc64-glibc from 
i586); the reason is that I do not have any header files containing 
definitions for JB_PC. What additional packages do I need?


Jan Engelhardt
-- 
--1283855629-1692274460-1150993591=:21525--
