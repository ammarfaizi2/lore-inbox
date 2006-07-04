Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbWGDF4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWGDF4w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 01:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWGDF4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 01:56:52 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:49336 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751201AbWGDF4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 01:56:52 -0400
Date: Mon, 3 Jul 2006 22:56:36 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org, hugh@veritas.com,
       kernel@kolivas.org, marcelo@kvack.org, nickpiggin@yahoo.com.au,
       ak@suse.de
Subject: Re: [RFC 3/8] Move HIGHMEM counter into highmem.c/.h
In-Reply-To: <20060704144724.65c43a38.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64.0607032253040.10856@schroedinger.engr.sgi.com>
References: <20060703215534.7566.8168.sendpatchset@schroedinger.engr.sgi.com>
 <20060703215550.7566.79975.sendpatchset@schroedinger.engr.sgi.com>
 <20060704144724.65c43a38.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2006, KAMEZAWA Hiroyuki wrote:

> Hi, I love this patch series :)
Thanks.
 
> I found this :
> == arch/um/kernel/mem.c ==
> 
> void mem_init(void)
> {
> <snip>
>    totalhigh_pages = highmem >> PAGE_SHIFT;
> ....
> ==
> this should be covered by CONFIG_HIGHMEM if you change totalhigh_pages 
> to be #define.

Ok. Will put a #ifdef CONFIG_HIGHMEM around that statement and the 
following one.


