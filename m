Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbUL2PtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbUL2PtS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 10:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbUL2PtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 10:49:18 -0500
Received: from eth0-0.arisu.projectdream.org ([194.158.4.191]:57821 "EHLO
	b.mx.projectdream.org") by vger.kernel.org with ESMTP
	id S261362AbUL2PtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 10:49:16 -0500
Date: Wed, 29 Dec 2004 16:49:35 +0100
From: Thomas Graf <tgraf@suug.ch>
To: Zhenyu Wu <y030729@njupt.edu.cn>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VQs in Gred!
Message-ID: <20041229154935.GK32419@postel.suug.ch>
References: <304306892.28448@njupt.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <304306892.28448@njupt.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zhenyu Wu <304306892.28448@njupt.edu.cn> 2004-12-29 15:54
> HOW does the Gred schedule packets of differnet priorities?

The packets are all enqueued onto the same queue. Gred is not
about prioritizing but only about dropping, hence once the packet
is enqueued it doesn't make sense to differ anymore. The difference
to normal red is that one can use separate red calculation
parameters per tcindex flow. tcindex is usually set via dsmark/
tcindex with contents of the dscp field. You might want to use a
more aggressive set of parameters for your bulk flows and treat
your interactive flows with more respect.
