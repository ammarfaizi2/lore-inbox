Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263309AbVBESh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbVBESh2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 13:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272716AbVBESh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 13:37:26 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:58617 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S272659AbVBESgy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 13:36:54 -0500
Subject: Preempt Real-time for ARM
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: linux-kernel@vger.kernel.org
Cc: sdietrich@mvista.com, mingo@elte.hu, linux@arm.linux.org.uk
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1107628604.5065.54.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 05 Feb 2005 10:36:46 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a release of Preempt Real-time for ARM . It includes everything
up to CONFIG_PREEMPT_RT , and all of the latency tracing except
interrupts off timing. The timing also excludes syscalls. This patch
includes only a port to OMAP boards. However, it should be straight
forward to get it working on other boards.

The biggest point of discussion relates to the interrupts in threads
implementation. It is largely identical to what is implemented in the
generic irq handling. However, ARM doesn't not implement generic irq
handling, and will not support it in the near future. I am not in
support of two different threaded interrupt implementations. 

I recently made a proposal to separate the threaded interrupt handling
from the generic irq handling, but I'm open to other ideas. 

The patch can be found at the following url

ftp://source.mvista.com/pub/realtime/arm/common_arm_realtime.patch


The patch order is as follows

http://www.kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.11-rc3.bz2
http://people.redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.11-rc3-V0.7.38-01
common_arm_realtime.patch

Enjoy!
Daniel Walker

