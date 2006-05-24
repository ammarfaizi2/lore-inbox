Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932621AbWEXGb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932621AbWEXGb5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 02:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932620AbWEXGb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 02:31:57 -0400
Received: from rune.pobox.com ([208.210.124.79]:18079 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S932616AbWEXGb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 02:31:56 -0400
Date: Wed, 24 May 2006 01:31:49 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Leech <christopher.leech@intel.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH 1/9] [I/OAT] DMA memcpy subsystem
Message-ID: <20060524063149.GE11414@localdomain>
References: <20060524001653.19403.31396.stgit@gitlost.site> <20060524002012.19403.50151.stgit@gitlost.site> <20060523174827.0ce1943b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060523174827.0ce1943b.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Chris Leech <christopher.leech@intel.com> wrote:
> >
> > +	for_each_cpu(i)
> 
> That's about to be deleted.  Please use for_each_possible_cpu().
> 
> That's if for_each_possible_cpu() is appropriate.

It is -- those loops traverse chan->local, which is alloc_percpu'd,
which allocates for all possible cpus.

