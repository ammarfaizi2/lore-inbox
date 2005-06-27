Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbVF0Ruh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVF0Ruh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 13:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVF0Rtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 13:49:31 -0400
Received: from graphe.net ([209.204.138.32]:46977 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261399AbVF0Rt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 13:49:27 -0400
Date: Mon, 27 Jun 2005 10:49:24 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andrew Morton <akpm@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [rfc] lockless pagecache
In-Reply-To: <20050627004624.53f0415e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0506271048260.19550@graphe.net>
References: <42BF9CD1.2030102@yahoo.com.au> <20050627004624.53f0415e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jun 2005, Andrew Morton wrote:

> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> >
> > First I'll put up some numbers to get you interested - of a 64-way Altix
> >  with 64 processes each read-faulting in their own 512MB part of a 32GB
> >  file that is preloaded in pagecache (with the proper NUMA memory
> >  allocation).
> 
> I bet you can get a 5x to 10x reduction in ->tree_lock traffic by doing
> 16-page faultahead.

Could be working into the prefault patch.... Good idea.

