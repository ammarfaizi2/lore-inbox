Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965091AbWDNBbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965091AbWDNBbx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 21:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWDNBbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 21:31:52 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:4498 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932451AbWDNBbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 21:31:51 -0400
Date: Thu, 13 Apr 2006 18:31:38 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: hugh@veritas.com, linux-kernel@vger.kernel.org, lee.schermerhorn@hp.com,
       linux-mm@kvack.org, taka@valinux.co.jp, marcelo.tosatti@cyclades.com,
       kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH 2/5] Swapless V2: Add migration swap entries
In-Reply-To: <20060413181716.152493b8.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0604131831150.16220@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
 <20060413235416.15398.49978.sendpatchset@schroedinger.engr.sgi.com>
 <20060413171331.1752e21f.akpm@osdl.org> <Pine.LNX.4.64.0604131728150.15802@schroedinger.engr.sgi.com>
 <20060413174232.57d02343.akpm@osdl.org> <Pine.LNX.4.64.0604131743180.15965@schroedinger.engr.sgi.com>
 <20060413180159.0c01beb7.akpm@osdl.org> <20060413181716.152493b8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Apr 2006, Andrew Morton wrote:

> Andrew Morton <akpm@osdl.org> wrote:
> >
> > Perhaps it would be better to go to
> >  sleep on some global queue, poke that queue each time a page migration
> >  completes?
> 
> Or take mmap_sem for writing in do_migrate_pages()?  That takes the whole
> pagefault path out of the picture.

We would have to take that for each task mapping the page. Very expensive 
operation.

