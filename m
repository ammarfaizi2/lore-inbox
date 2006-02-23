Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751716AbWBWTeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbWBWTeX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 14:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751717AbWBWTeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 14:34:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7565 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751716AbWBWTeW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 14:34:22 -0500
Date: Thu, 23 Feb 2006 11:33:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: alokk@calsoftinc.com, manfred@colorfullife.com, penberg@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Slab: Node rotor for freeing alien caches and remote per cpu
 pages.
Message-Id: <20060223113331.6b345e1b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602231036480.13184@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0602231036480.13184@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
>
> The cache reaper currently tries to free all alien caches and all remote
>  per cpu pages in each pass of cache_reap.

umm, why?  We have a reap timer per cpu - why doesn't each CPU drain its
own stuff and its own node's stuff and leave the other nodes&cpus alone?
