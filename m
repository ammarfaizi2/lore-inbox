Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVBRTf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVBRTf3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 14:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVBRTf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 14:35:29 -0500
Received: from mail.siemenscom.com ([12.146.131.10]:23515 "EHLO
	mail.siemenscom.com") by vger.kernel.org with ESMTP id S261466AbVBRTfR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 14:35:17 -0500
Message-ID: <13272676F5725D4397BD0E6A11C84968054DE792@stca208a.bus.sc.rolm.com>
From: "Bloch, Jack" <jack.bloch@siemens.com>
To: linux-kernel@vger.kernel.org
Subject: Spinlock and cache coherency
Date: Fri, 18 Feb 2005 11:34:44 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running a SuSE 2.4.19 Kernel. We have a quad CPU system (actually two
physical CPU's with hyperthreading. We have encountered a problem where
three of four CPU's are locked in the NET_RX_ACTION waiting for the
BR_NETPROTO_LOCK spinlock. The fourth is spiinning on another internal
driver spinlock (spinlock_irqsave). The author of this driver points out to
us the cache coherency issues related to spinlock specifically with the
Intel errata G40 "Potential Loss of Data Coherency During MP Data Ownership
Transfer". Anyone seen any of these issues?


Please CC me directly on any responses.


Regards,


Jack
