Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261333AbTAJLdu>; Fri, 10 Jan 2003 06:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261545AbTAJLdu>; Fri, 10 Jan 2003 06:33:50 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:19935 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id <S261333AbTAJLdt>; Fri, 10 Jan 2003 06:33:49 -0500
Date: Fri, 10 Jan 2003 12:42:34 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: spin_locks without smp.
Message-ID: <Pine.LNX.4.51.0301101238560.6124@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while browsing through the network drivers about the etherleak issue i
found that some drivers have:

#ifdef CONFIG_SMP
	spin_lock_irqsave(...)
#endif

and some just:

	spin_lock_irqsave(...)

or similar.
Which version should be practiced? i thought spinlocks are irrelevant
without SMP so we should use #ifdef to shorten the execution path.

Regards,
Maciej Soltysiak

