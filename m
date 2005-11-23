Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbVKWRDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbVKWRDk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 12:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbVKWRDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 12:03:39 -0500
Received: from graphe.net ([209.204.138.32]:49593 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S932093AbVKWRDi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 12:03:38 -0500
Date: Wed, 23 Nov 2005 09:03:34 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, Rohit Seth <rohit.seth@intel.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Free pages from local pcp lists under tight memory
 conditions
In-Reply-To: <Pine.LNX.4.64.0511230834160.13959@g5.osdl.org>
Message-ID: <Pine.LNX.4.62.0511230857260.11339@graphe.net>
References: <20051122161000.A22430@unix-os.sc.intel.com>
 <20051122213612.4adef5d0.akpm@osdl.org> <Pine.LNX.4.62.0511222238530.2084@graphe.net>
 <Pine.LNX.4.64.0511230834160.13959@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2005, Linus Torvalds wrote:

> On Tue, 22 Nov 2005, Christoph Lameter wrote:
> > On Tue, 22 Nov 2005, Andrew Morton wrote:
> > > +extern int drain_local_pages(void);
> > drain_cpu_pcps?
> 
> Please no.
> 
> If there is something I _hate_ it's bad naming. And "pcps" is a totally 
> unintelligible name.
> 
> Write it out. If a function is so trivial that you can't be bothered to 
> write out what the name means, that function shouldn't exist at all. 
> Conversely, if it's worth doing, it's worth writing out a name.


drain_one_cpus_pages_from_per_cpu_pagesets()

drain_one_cpus_remote_pages_from_per_cpu_pagesets()

drain_all_per_cpu_pagesets()

?

