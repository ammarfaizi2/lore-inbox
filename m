Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbUCPSh4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 13:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbUCPShz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 13:37:55 -0500
Received: from mailhost.cs.auc.dk ([130.225.194.6]:35061 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP id S261203AbUCPShu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 13:37:50 -0500
Subject: spurious 8259A interrupt
From: Emmanuel Fleury <fleury@cs.auc.dk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Aalborg University -- Computer Science Dept.
Message-Id: <1079462154.24676.29.camel@rade7.s.cs.auc.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 16 Mar 2004 19:35:55 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed today that I had several "spurious 8259A interrupt":

Dec 20 15:02:45 hermes vmunix: spurious 8259<3>[drm:radeon_cp_init]
*ERROR* radeon_cp_init called without lock held
...
Dec 20 16:54:17 hermes vmunix: spurious 8259A interrupt: IRQ7.
...
Jan  3 11:29:06 hermes vmunix: spurious 8259A interrupt: I<6>cs: memory
probe 0xa0000000-0xa0ffffff: clean.
...
Feb 29 12:59:39 hermes vmunix: spurious 8259A in<4>atkbd.c: Keyboard on
isa0060/serio0 reports too many keys pressed.
...
Mar  1 00:03:12 hermes vmunix: spurious 8259A interrupt:
I<3>[drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
...
Mar  8 03:11:24 hermes vmunix: spurious 8259A interrupt:
I<7>orinoco_lock() called with hw_unavailable (dev=d5a80000)


After some Googling, I found out this:
http://test.linuxfromscratch.org/faq/#spurious-8259A-interrupt

So, I know it is no harm. But, it is possibly due to a device driver
which is not properly doing its job. Can somebody tell me how to correct
this bug (without have the work around of tingling klogd).

Regards
-- 
Emmanuel Fleury

Computer Science Department, |  Office: B1-201
Aalborg University,          |  Phone:  +45 96 35 72 23
Fredriks Bajersvej 7E,       |  Fax:    +45 98 15 98 89
9220 Aalborg East, Denmark   |  Email:  fleury@cs.auc.dk

