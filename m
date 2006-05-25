Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030279AbWEYRG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030279AbWEYRG4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 13:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030287AbWEYRGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 13:06:55 -0400
Received: from graphe.net ([209.204.138.32]:28362 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S1030279AbWEYRGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 13:06:55 -0400
Date: Thu, 25 May 2006 10:06:46 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: Christoph Lameter <clameter@sgi.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/3] mm: tracking shared dirty pages
In-Reply-To: <1148576582.10561.83.camel@lappy>
Message-ID: <Pine.LNX.4.64.0605251004110.30707@graphe.net>
References: <20060525135534.20941.91650.sendpatchset@lappy> 
 <20060525135555.20941.36612.sendpatchset@lappy> 
 <Pine.LNX.4.64.0605250921300.23726@schroedinger.engr.sgi.com>
 <1148576582.10561.83.camel@lappy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -2.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2006, Peter Zijlstra wrote:

> Ah, I see what you're saying here. Good point, David, Hugh?
> 
> The reason I did it was because of Hugh's trick to use MAP_SHARED
> protection and building on top of it naturally solves the patch conflict
> Andrew would have had to resolve otherwise.

I guess what we wanted is a patch that addresses the concern of both 
patches and not a combination of the patches. IMHO the dirty notification 
of David's patch is possible with the shared dirty pages patch if we allow 
the set_page_dirty method in address operations to sleep and return an 
error code. However, this may raise some additional issues because we have 
to check whenever we dirty a page.


