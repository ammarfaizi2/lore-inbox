Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWD1XJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWD1XJj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 19:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWD1XJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 19:09:39 -0400
Received: from sccrmhc13.comcast.net ([204.127.200.83]:13523 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S932086AbWD1XJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 19:09:38 -0400
Subject: IOAPIC (?) problems on a VIA K8T800 system
From: Nicholas Miell <nmiell@comcast.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Date: Fri, 28 Apr 2006 16:09:35 -0700
Message-Id: <1146265775.2348.11.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randomly, my VIA K8T800-based system will stop receiving all interrupts
(the columns in /proc/interrupts stop incrementing) from either the SATA
controller or all of the UHCI controllers (IRQs 16 or 18, respectively).

AFAICT, booting with noapic makes this go away, but since I can't
reliably reproduce it, I don't know for sure if that in fact works
around the problem.

Removing and then reloading the driver module (or using sysfs to
unbind/bind the devices) makes the problem temporarily go away.

This is with the latest FC5 kernel (kernel-2.6.16-1.2096_FC5) on an SMP
AMD64 system, but it's been doing this occasionally on every kernel I've
used for quite some time now.

-- 
Nicholas Miell <nmiell@comcast.net>

