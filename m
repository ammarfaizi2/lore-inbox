Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263472AbUCTQjZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 11:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263474AbUCTQjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 11:39:25 -0500
Received: from 69-90-55-107.fastdsl.ca ([69.90.55.107]:5308 "EHLO
	TMA-1.brad-x.com") by vger.kernel.org with ESMTP id S263472AbUCTQjW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 11:39:22 -0500
Subject: badness in kernel/softirq.c
From: Brad Laue <brad@brad-x.com>
Reply-To: brad@brad-x.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: brad-x.com
Message-Id: <1079800804.13796.5.camel@Discovery.brad-x.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 20 Mar 2004 11:40:05 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a followup to my earlier mail 'ksoftirqd using mysteriously high
amounts of CPU time'. After working briefly with Andrew Morton on the
issue we seem to have identified the 'pppoe' userspace program as the
culprit for that issue.

After some playing with kernel options I switched my PPPoE connection
options from asynctty to synctty, and observed almost no usage of
ksoftirqd/0 at all, as it should be.

However, the pppoe process maintains an extreme amount of CPU
utilization, cutting off the machines ability to send and receive at its
fastest possible rate. Additionally the attached error fills dmesg after
a couple of days (vanilla 2.6.3 kernel).

I'm hoping the PPP stuff in the kernel is well enough maintained that a
problem/solution can be identified..

Thanks in advance!

Brad

