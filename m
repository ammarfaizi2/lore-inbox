Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265293AbUAAEnb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 23:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265294AbUAAEna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 23:43:30 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:56242 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S265293AbUAAEn3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 23:43:29 -0500
Date: Thu, 01 Jan 2004 17:41:39 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: How to avoid 'lost interrupt' messages post-resume?
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1072932095.6722.22.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: text/plain
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I have Software Suspend successfully running under 2.4.23 on a dual
Celeron at OSDL, with only one outstanding issue: sometimes, after
copying back the original kernel, I see 'hda: lost interrupt' and after
another pause 'hdb:lost interrupt' messages. Apart from that, everything
works fine (the machine has just suspended for the 46th time on the
trot). I'm wanting to know if there's something I can do to fix this
issue.

Currently, prior to suspending, I set all irq affinities to CPU 0 (which
does the suspend), save the state of the APICs and disable them and
disable interrupts. At resume time, I again set the affinities to CPU 0
and disable the APICs and interrupts prior to copying the original
kernel back. After copying the original kernel back, I restore the
original (pre-suspend) affinities and APIC settings & reenable
interrupts (incomplete list). I'm no hardware expert, so feel free to
tell me I'm doing something lame! Apart from these lost interrupts, all
seems to work just fine.

Regards,

Nigel
-- 
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

