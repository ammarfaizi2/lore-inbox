Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWGRDhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWGRDhS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 23:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWGRDhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 23:37:18 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:46766 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751142AbWGRDhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 23:37:16 -0400
Date: Mon, 17 Jul 2006 20:37:05 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: linux-mm <linux-mm@kvack.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: inactive-clean list
In-Reply-To: <1153167857.31891.78.camel@lappy>
Message-ID: <Pine.LNX.4.64.0607172035140.28956@schroedinger.engr.sgi.com>
References: <1153167857.31891.78.camel@lappy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2006, Peter Zijlstra wrote:

> This patch implements the inactive_clean list spoken of during the VM summit.
> The LRU tail pages will be unmapped and ready to free, but not freeed.
> This gives reclaim an extra chance.

I thought we wanted to just track the number of unmapped clean pages and 
insure that they do not go under a certain limit? That would not require
any locking changes but just a new zoned counter and a check in the dirty
handling path.

