Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261800AbVB1WxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbVB1WxN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 17:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbVB1WxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 17:53:13 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:56823 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261805AbVB1Wuv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 17:50:51 -0500
Subject: Generic IRQ handling
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1109631050.25655.55.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 28 Feb 2005 14:50:50 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is a change to the generic IRQ handling in the ARM RT patch (as of
today) that should be discussed here.

I added a macro define called __ARCH_HAS_IRQ_DESC_T that removes the
generic irq_desc_t and hw_irq_controller if the architecture has them
defined already. I don't see any problems with this, and it makes ARM
integration a little easier . 

I also modified the make files so that individual files in kernel/irq/
can be compiled depending on config options. 

The full ARM RT patch is here,

ftp://source.mvista.com/pub/realtime/arm/common_arm_realtime.patch

Daniel Walker

