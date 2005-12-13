Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbVLMSIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbVLMSIQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 13:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbVLMSIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 13:08:16 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:4579 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932464AbVLMSIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 13:08:15 -0500
Date: Tue, 13 Dec 2005 10:07:53 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Eric Dumazet <dada1@cosmosbay.com>
cc: Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       Simon.Derr@bull.net, ak@suse.de
Subject: Re: [PATCH] Cpuset: rcu optimization of page alloc hook
In-Reply-To: <439F0B43.4080500@cosmosbay.com>
Message-ID: <Pine.LNX.4.62.0512131006070.22803@schroedinger.engr.sgi.com>
References: <20051211233130.18000.2748.sendpatchset@jackhammer.engr.sgi.com>
 <439D39A8.1020806@cosmosbay.com> <20051212020211.1394bc17.pj@sgi.com>
 <20051212021247.388385da.akpm@osdl.org> <20051213075345.c39f335d.pj@sgi.com>
 <439EF75D.50206@cosmosbay.com> <Pine.LNX.4.62.0512130938130.22803@schroedinger.engr.sgi.com>
 <439F0B43.4080500@cosmosbay.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2005, Eric Dumazet wrote:

> If this variable is not frequently used, why then define its own cache ?
> 
> Ie why not use kmalloc() and let kernel use a general cache ?

I was also wondering why Paul switched to use the slab allocator. One 
reason may have been to simplify rcu?
