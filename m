Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161200AbWGNCaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161200AbWGNCaS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 22:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161192AbWGNCaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 22:30:18 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:36574 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161200AbWGNCaQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 22:30:16 -0400
Date: Thu, 13 Jul 2006 19:29:52 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: arjan@infradead.org, torvalds@osdl.org, penberg@cs.helsinki.fi,
       mingo@elte.hu, sekharan@us.ibm.com, linux-kernel@vger.kernel.org,
       nagar@watson.ibm.com, balbir@in.ibm.com
Subject: Re: [patch] lockdep: annotate mm/slab.c
In-Reply-To: <20060713161620.f61d2ac0.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0607131929050.31444@schroedinger.engr.sgi.com>
References: <1152763195.11343.16.camel@linuxchandra> <20060713071221.GA31349@elte.hu>
 <20060713002803.cd206d91.akpm@osdl.org> <20060713072635.GA907@elte.hu>
 <20060713004445.cf7d1d96.akpm@osdl.org> <20060713124603.GB18936@elte.hu>
 <84144f020607130858l60792ac0t5f9cdabf1902339c@mail.gmail.com>
 <Pine.LNX.4.64.0607131156060.5623@g5.osdl.org> <1152818472.3024.75.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.64.0607131543040.30558@schroedinger.engr.sgi.com>
 <20060713161620.f61d2ac0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2006, Andrew Morton wrote:

> > Whew! We drop the list lock before calling slab_destroy.
> 
> Well we did, up until about ten minutes ago.
> 
> free_block()'s droppage of l3->list_lock around the slab_destroy() call was
> just reverted, due to Shailabh confirming that it caused corruption.

How would this slab become corrupted if it is no longer on the lists?
