Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVCOQwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVCOQwc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 11:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbVCOQwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 11:52:32 -0500
Received: from 209-204-138-32.dsl.static.sonic.net ([209.204.138.32]:9221 "EHLO
	graphe.net") by vger.kernel.org with ESMTP id S261475AbVCOQv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 11:51:56 -0500
Date: Tue, 15 Mar 2005 08:51:04 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.graphe.net
To: Christoph Hellwig <hch@infradead.org>
cc: akpm@osdl.org, shai@scalex86.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Per cpu irq stat
In-Reply-To: <20050315091433.GA29079@infradead.org>
Message-ID: <Pine.LNX.4.58.0503150850300.24480@server.graphe.net>
References: <Pine.LNX.4.58.0503142230050.11651@server.graphe.net>
 <20050315091433.GA29079@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2005, Christoph Hellwig wrote:

> On Mon, Mar 14, 2005 at 10:32:34PM -0800, Christoph Lameter wrote:
> > The definition of the irq_stat as an array means that the individual
> > elements of the irq_stat array are located on one NUMA node requiring
> > internode traffic to access irq_stat from other nodes. This patch makes
> > irq_stat a per_cpu variable which allows most accesses to be local.
>
> There's architectures accessing it from assemly.

The patch is i386 specific!

> But furthermore there's absolutely not point for the irq_stat structure
> at all anymore now that we have the per_cpu infrastructure.  so kill it
> completely and let every architecture just provide a local_softirq_pending
> macro.

That would require reworking a lot of architectures.

