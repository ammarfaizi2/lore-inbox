Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268043AbUIKArb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268043AbUIKArb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 20:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268058AbUIKAra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 20:47:30 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:60559 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S268043AbUIKAr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 20:47:29 -0400
X-BrightmailFiltered: true
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: <linux-kernel@vger.kernel.org>
Cc: <paulus@samba.org>
Subject: Memory barrier on ppc and general
Date: Fri, 10 Sep 2004 17:47:25 -0700
Organization: Cisco Systems
Message-ID: <004201c49798$e7ff06d0$7b3a47ab@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4939.300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list:

I have a question about memory barrier.

1. first, this is a ppc-specific question. From the source of Linux ppc, I
see mb() and rmb() are defined as "sync", while "wmb()" is defined as
"eieio", but from the manual I see why eieio can't be used for rmb() and
mb() also. Could someone enlighten me?

2. second, does the memory barrier also work for for memory-mapped IO
registers? For example, a wmb() guarantees two stores to memory are
in-order, but say the second store is actually a hardware register. Would
the barrier still work?

Thanks for your answer.

Hua

