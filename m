Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbUKLFwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbUKLFwa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 00:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262455AbUKLFw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 00:52:29 -0500
Received: from twinlark.arctic.org ([168.75.98.6]:212 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S262453AbUKLFw2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 00:52:28 -0500
Date: Thu, 11 Nov 2004 21:52:27 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: linux-kernel@vger.kernel.org
Subject: CONFIG_X86_PM_TIMER is slow
Message-ID: <Pine.LNX.4.61.0411112143200.1846@twinlark.arctic.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

when using CONFIG_X86_PM_TIMER i'm finding that gettimeofday() calls take 
2.8us on a p-m 1.4GHz box... which is an order of magnitude slower than 
TSC-based solutions.

on one workload i'm seeing a 7% perf improvement by booting "acpi=off" to 
force it to use tsc instead of the PM timer... (the workload calls 
gettimeofday too frequently, but i can't change that).

i'm curious why other folks haven't run into this -- is it because most 
systems have HPET timer as well and that's not nearly as bad as PM timer?

-dean
