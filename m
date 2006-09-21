Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWIUMSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWIUMSp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 08:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWIUMSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 08:18:45 -0400
Received: from build.arklinux.osuosl.org ([140.211.166.26]:50599 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S1751144AbWIUMSo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 08:18:44 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: linux-kernel@vger.kernel.org
Subject: "Int 6: CR2" on bootup w/ 2.6.18-rc7-mm1
Date: Thu, 21 Sep 2006 14:12:08 +0200
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609211412.08561.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happens when trying to boot 2.6.18-rc7-mm1 on a truly ancient (Pentium 1) 
box:

Uncompressing Linux... Ok, booting the kernel.

Int 6: CR2 00000000 err 00000000 EIP c0381719 CS 00000060 flags 00010046
Stack: 00000000 c036f4d1 00000000 c0100199 000001b8 0505c600 00c036cc 001f0fc3

(No further details even with initcall_debug loglevel=7).
c0381719 appears to be in ACPI code -- but the Int 6 error happens even with 
acpi=off.
