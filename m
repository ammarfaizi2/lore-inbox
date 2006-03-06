Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWCFQZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWCFQZa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 11:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbWCFQZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 11:25:30 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:51139 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750771AbWCFQZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 11:25:29 -0500
Date: Mon, 6 Mar 2006 08:24:55 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, kiran@scalex86.org,
       alokk@calsoftinc.com
Subject: Re: cache_reap(): Further reduction in interrupt holdoff
In-Reply-To: <84144f020603052349p4e95381ar92c3f80027557c12@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0603060823440.23752@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0603031530380.15581@schroedinger.engr.sgi.com>
 <84144f020603052349p4e95381ar92c3f80027557c12@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Mar 2006, Pekka Enberg wrote:

> Touched processing worries me little because it's used when there's
> high allocation pressure. Do you have any numbers where this patch
> helps?

We had frequent holdoffs >30usec in cache_reap() without this patch. Now 
it happens once in awhile.

