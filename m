Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbVLMUIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbVLMUIl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 15:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbVLMUIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 15:08:41 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:11694 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751367AbVLMUIk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 15:08:40 -0500
Date: Tue, 13 Dec 2005 12:08:14 -0800
From: Paul Jackson <pj@sgi.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       Simon.Derr@bull.net, ak@suse.de, clameter@sgi.com
Subject: Re: [PATCH] Cpuset: rcu optimization of page alloc hook
Message-Id: <20051213120814.f7e1d73d.pj@sgi.com>
In-Reply-To: <439EF75D.50206@cosmosbay.com>
References: <20051211233130.18000.2748.sendpatchset@jackhammer.engr.sgi.com>
	<439D39A8.1020806@cosmosbay.com>
	<20051212020211.1394bc17.pj@sgi.com>
	<20051212021247.388385da.akpm@osdl.org>
	<20051213075345.c39f335d.pj@sgi.com>
	<439EF75D.50206@cosmosbay.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Detail question ...

Eric wrote:
> Say you move to read mostly most of struct kmem_cache *

Does the following:

	struct kmem_cache *cpuset_cache __read_mostly;

mark just the one word pointer 'cpuset_cache' as __read_mostly,
or does it mark the whole dang cpuset cache?

I presume it just marks the one pointer word.  Am I wrong?

I ask because the subtle phrasing of your comment reads to
my ear as if you knew it marked the entire cache.  I can't
tell if that is due to my ears having a different language
accent than yours, or if it is due to my getting this wrong.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
