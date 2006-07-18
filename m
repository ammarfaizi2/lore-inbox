Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWGROpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWGROpf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 10:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWGROpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 10:45:35 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:45518 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932251AbWGROpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 10:45:35 -0400
Date: Tue, 18 Jul 2006 07:45:21 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: mbligh@mbligh.org, a.p.zijlstra@chello.nl, linux-mm@kvack.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: inactive-clean list
In-Reply-To: <20060718072545.7cfed5b2.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0607180742580.31065@schroedinger.engr.sgi.com>
References: <1153167857.31891.78.camel@lappy>
 <Pine.LNX.4.64.0607172035140.28956@schroedinger.engr.sgi.com>
 <1153224998.2041.15.camel@lappy> <Pine.LNX.4.64.0607180557440.30245@schroedinger.engr.sgi.com>
 <44BCE86A.4030602@mbligh.org> <Pine.LNX.4.64.0607180659310.30887@schroedinger.engr.sgi.com>
 <20060718072545.7cfed5b2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2006, Andrew Morton wrote:

> Christoph Lameter <clameter@sgi.com> wrote:
> > What other types of non freeable pages could exist?
> 
> PageWriteback() pages (potentially all of memory)

Doesnt write throttling take care of that?

> Pinned pages (various transient conditions, mainly get_user_pages())

Hmm....
 
> Some pages whose buffers are attached to an ext3 journal.

These are just pinned by an increased refcount right?
 
> Possibly NFS unstable pages.

These are tracked by NR_NFS_UNSTABLE.

Maybe we need a NR_UNSTABLE that includes pinned pages?
