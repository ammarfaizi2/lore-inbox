Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262716AbUKXPe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262716AbUKXPe6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 10:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262699AbUKXPaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 10:30:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33152 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262679AbUKXP2U
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 10:28:20 -0500
Date: Wed, 24 Nov 2004 08:40:20 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Nikita Danilov <nikita@clusterfs.com>, Linux-Kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH]: 1/4 batch mark_page_accessed()
Message-ID: <20041124104020.GA9777@logos.cnet>
References: <16800.47044.75874.56255@gargle.gargle.HOWL> <20041121131250.26d2724d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041121131250.26d2724d.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2004 at 01:12:50PM -0800, Andrew Morton wrote:
> Nikita Danilov <nikita@clusterfs.com> wrote:
> >
> > Batch mark_page_accessed() (a la lru_cache_add() and lru_cache_add_active()):
> >  page to be marked accessed is placed into per-cpu pagevec
> >  (page_accessed_pvec). When pagevec is filled up, all pages are processed in a
> >  batch.
> > 
> >  This is supposed to decrease contention on zone->lru_lock.
> 
> Looks sane, althought it does add more atomic ops (the extra
> get_page/put_page).  Some benchmarks would be nice to have.

I'll run STP benchmarks as soon as STP is working again. 
