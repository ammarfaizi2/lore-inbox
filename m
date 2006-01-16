Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWAPGv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWAPGv5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 01:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWAPGv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 01:51:57 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:5579 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751095AbWAPGv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 01:51:56 -0500
Date: Sun, 15 Jan 2006 22:51:44 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: Race in new page migration code?
In-Reply-To: <Pine.LNX.4.61.0601151053420.4500@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.62.0601152251080.17034@schroedinger.engr.sgi.com>
References: <20060114155517.GA30543@wotan.suse.de>
 <Pine.LNX.4.62.0601140955340.11378@schroedinger.engr.sgi.com>
 <20060114181949.GA27382@wotan.suse.de> <Pine.LNX.4.62.0601141040400.11601@schroedinger.engr.sgi.com>
 <Pine.LNX.4.61.0601151053420.4500@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Jan 2006, Hugh Dickins wrote:

> On Sat, 14 Jan 2006, Christoph Lameter wrote:
> > 
> > Also remove the WARN_ON since its now even possible that other actions of 
> > the VM move the pages into the LRU lists while we scan for pages to
> > migrate.
> 
> Good.  And whether it's your or Nick's patch that goes in, please also
> remove that PageReserved test which you recently put in check_pte_range.

Zero pages are still marked reserved AFAIK. Why not check for it?

