Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbVC3MX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbVC3MX2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 07:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVC3MX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 07:23:27 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:49340 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261878AbVC3MXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 07:23:13 -0500
Date: Wed, 30 Mar 2005 13:22:53 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: David Howells <dhowells@redhat.com>
cc: "David S. Miller" <davem@davemloft.net>, Ian Molton <spyro@f2s.com>,
       nickpiggin@yahoo.com.au, akpm@osdl.org, tony.luck@intel.com,
       benh@kernel.crashing.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] freepgt: free_pgtables use vma list
In-Reply-To: <22627.1112179577@redhat.com>
Message-ID: <Pine.LNX.4.61.0503301317370.20171@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503292223090.18131@goblin.wat.veritas.com> 
    <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com> 
    <Pine.LNX.4.61.0503231710310.15274@goblin.wat.veritas.com> 
    <4243A257.8070805@yahoo.com.au> 
    <20050325092312.4ae2bd32.davem@davemloft.net> 
    <20050325162926.6d28448b.davem@davemloft.net> 
    <22627.1112179577@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2005, David Howells wrote:
> Hugh Dickins <hugh@veritas.com> wrote:
> > On Fri, 25 Mar 2005, David S. Miller wrote:
> > 
> > [ of flush_tlb_pgtables ]
> 
> > > Let's make it so that the flush can be queued up
> > > at pmd_clear() time, as that's what we really want.
> > > 
> > > Something like:
> > > 
> > > 	pmd_clear(mm, vaddr, pmdp);
> > > 
> > > I'll try to play with something like this later.
> > 
> > Depends really on what DavidH wants there, not clear to me.
> > I suspect Ian can live without his printk!
> 
> I could do the zapping in pmd_clear() instead, I suppose. It's just that it
> only needs to be done once when tearing down the page tables; not for every
> PMD.

Sounds like we should leave flush_tlb_pgtables as it is
(apart from the issue in its frv implementation that you noticed).

Hugh
