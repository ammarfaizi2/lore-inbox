Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262206AbVCOHgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbVCOHgj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 02:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbVCOHgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 02:36:39 -0500
Received: from 209-204-138-32.dsl.static.sonic.net ([209.204.138.32]:58885
	"EHLO graphe.net") by vger.kernel.org with ESMTP id S262206AbVCOHgg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 02:36:36 -0500
Date: Mon, 14 Mar 2005 23:36:31 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.graphe.net
To: Andrew Morton <akpm@osdl.org>
cc: shai@scalex86.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Per cpu irq stat
In-Reply-To: <20050314224803.37cd21fe.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0503142332250.12724@server.graphe.net>
References: <Pine.LNX.4.58.0503142230050.11651@server.graphe.net>
 <20050314224803.37cd21fe.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2005, Andrew Morton wrote:

> >  +DEFINE_PER_CPU(irq_cpustat_t, irq_stat)
> >  ____cacheline_maxaligned_in_smp;
>
> Why is this marked ____cacheline_maxaligned_in_smp?

In order to avoid potential false aliasing I guess. irq_cpustat_t is
already marked ___cacheline_aligned though which should be sufficient.
Shai?

