Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVCHFeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVCHFeD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 00:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVCHFeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 00:34:03 -0500
Received: from fire.osdl.org ([65.172.181.4]:60290 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261553AbVCHFdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 00:33:44 -0500
Date: Mon, 7 Mar 2005 21:33:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] unified device list allocator
Message-Id: <20050307213302.560de053.akpm@osdl.org>
In-Reply-To: <20050308051818.GI3120@waste.org>
References: <20050308051818.GI3120@waste.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> +	/* search for insertion point in reverse for dynamic allocation */
>  +	list_for_each_prev(l, list) {

hrmph.  Any time we do anything in O(n) time, some smarty comes along with
a workload which blows us out of the water.  Although it's hard to think of
any register_blkdev()-intensive workloads.

It's not possible to do this with prio-trees?
