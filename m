Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262285AbVCOGs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbVCOGs3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 01:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbVCOGs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 01:48:28 -0500
Received: from fire.osdl.org ([65.172.181.4]:37340 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262285AbVCOGsZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 01:48:25 -0500
Date: Mon, 14 Mar 2005 22:48:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <christoph@lameter.com>
Cc: shai@scalex86.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Per cpu irq stat
Message-Id: <20050314224803.37cd21fe.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503142230050.11651@server.graphe.net>
References: <Pine.LNX.4.58.0503142230050.11651@server.graphe.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <christoph@lameter.com> wrote:
>
> The definition of the irq_stat as an array means that the individual
>  elements of the irq_stat array are located on one NUMA node requiring
>  internode traffic to access irq_stat from other nodes. This patch makes
>  irq_stat a per_cpu variable which allows most accesses to be local.

OK...

The wordwrapping monster got at your patch, but I fixed it up.

>  +DEFINE_PER_CPU(irq_cpustat_t, irq_stat)
>  ____cacheline_maxaligned_in_smp;

Why is this marked ____cacheline_maxaligned_in_smp?
