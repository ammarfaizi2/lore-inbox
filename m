Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965063AbWDNA37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965063AbWDNA37 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 20:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965070AbWDNA37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 20:29:59 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:55512 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965063AbWDNA36 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 20:29:58 -0400
Date: Thu, 13 Apr 2006 17:29:46 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: hugh@veritas.com, linux-kernel@vger.kernel.org, lee.schermerhorn@hp.com,
       linux-mm@kvack.org, taka@valinux.co.jp, marcelo.tosatti@cyclades.com,
       kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH 2/5] Swapless V2: Add migration swap entries
In-Reply-To: <20060413171331.1752e21f.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0604131728150.15802@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
 <20060413235416.15398.49978.sendpatchset@schroedinger.engr.sgi.com>
 <20060413171331.1752e21f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Apr 2006, Andrew Morton wrote:

> Christoph Lameter <clameter@sgi.com> wrote:
> >
> > +
> >  +	if (unlikely(is_migration_entry(entry))) {
> 
> Perhaps put the unlikely() in is_migration_entry()?
> 
> >  +		yield();
> 
> Please, no yielding.
> 
> _especially_ no unchangelogged, uncommented yielding.

Page migration is ongoing so its best to do something else first.

Add a comment?
