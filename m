Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbVKOD2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbVKOD2n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 22:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbVKOD2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 22:28:41 -0500
Received: from main.gmane.org ([80.91.229.2]:37825 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932329AbVKOD2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 22:28:40 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Mon, 14 Nov 2005 22:27:03 -0500
Message-ID: <dlbkhv$hp4$1@sea.gmane.org>
References: <58MJb-2Sn-37@gated-at.bofh.it> <58NvO-46M-23@gated-at.bofh.it> <58Rpx-1m6-11@gated-at.bofh.it> <58UGF-6qR-27@gated-at.bofh.it> <58UQf-6Da-3@gated-at.bofh.it> <437933B6.1000503@shaw.ca> <1132020468.27215.25.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ool-18b913a0.dyn.optonline.net
User-Agent: KNode/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

> Um, but it's really really bad for drivers to do that.

Not really. The Windows driver calls kernel API (in this case ndiswraper
functions) whenever it needs to wait on an event, sleep etc. So if preempt
is enabled on the way back (from Windows driver to Linux kernel call), it
shouldn't be a problem as far as preempt is concerned.

Giri

