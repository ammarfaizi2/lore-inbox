Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWGDCiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWGDCiX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 22:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWGDCiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 22:38:23 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:59304 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751261AbWGDCiW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 22:38:22 -0400
Date: Mon, 3 Jul 2006 19:37:38 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Marcelo Tosatti <marcelo@kvack.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       penberg@cs.helsinki.fi, paulmck@us.ibm.com, nickpiggin@yahoo.com.au,
       tytso@mit.edu, dgc@sgi.com, ak@suse.de
Subject: Re: [RFC 0/4] Object reclaim via the slab allocator V1
In-Reply-To: <20060704020759.GB9212@dmt>
Message-ID: <Pine.LNX.4.64.0607031935130.10401@schroedinger.engr.sgi.com>
References: <20060619184651.23130.62875.sendpatchset@schroedinger.engr.sgi.com>
 <20060628174329.20adbc2a.akpm@osdl.org> <Pine.LNX.4.64.0606281741380.24393@schroedinger.engr.sgi.com>
 <20060628200942.6eea8ae5.akpm@osdl.org> <Pine.LNX.4.64.0606291017120.27705@schroedinger.engr.sgi.com>
 <20060703004444.GA7688@dmt> <Pine.LNX.4.64.0607031058400.26397@schroedinger.engr.sgi.com>
 <20060703231103.GA5160@dmt> <Pine.LNX.4.64.0607031837280.10292@schroedinger.engr.sgi.com>
 <20060704020759.GB9212@dmt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2006, Marcelo Tosatti wrote:

> > If used for the dcache then dentry handling must be changed so that the 
> > refcount at the beginnDing of the slab is 1 if the object is reclaimable 
> > and the higher refcount needs to be an indicator that the object is in 
> > use. I am not saying that existing use gets us there. Maybe we need to 
> > call this a reclaim flag instead of a refcount?
> 
> I think the cache has to decide...

The cache decides by setting the refcount/reclaim flag.

I doubt that I get to revising this in the next week. Can we have a slab 
reclaim meeting in Ottawa?

