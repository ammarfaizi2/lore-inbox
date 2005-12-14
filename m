Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbVLNIkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbVLNIkh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 03:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbVLNIkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 03:40:37 -0500
Received: from omx3-ext.sgi.com ([192.48.171.25]:20694 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932139AbVLNIkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 03:40:36 -0500
Date: Wed, 14 Dec 2005 00:40:14 -0800
From: Paul Jackson <pj@sgi.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: clameter@engr.sgi.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, Simon.Derr@bull.net, ak@suse.de
Subject: Re: [PATCH] Cpuset: rcu optimization of page alloc hook
Message-Id: <20051214004014.ada450e6.pj@sgi.com>
In-Reply-To: <439FD295.7070102@cosmosbay.com>
References: <20051211233130.18000.2748.sendpatchset@jackhammer.engr.sgi.com>
	<439D39A8.1020806@cosmosbay.com>
	<20051212020211.1394bc17.pj@sgi.com>
	<20051212021247.388385da.akpm@osdl.org>
	<20051213075345.c39f335d.pj@sgi.com>
	<439EF75D.50206@cosmosbay.com>
	<Pine.LNX.4.62.0512130938130.22803@schroedinger.engr.sgi.com>
	<439F0B43.4080500@cosmosbay.com>
	<20051213130350.464a3054.pj@sgi.com>
	<439F3F6E.6010701@cosmosbay.com>
	<20051213142346.ccd3081a.pj@sgi.com>
	<439FD295.7070102@cosmosbay.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric wrote:
> So for small objects (<= 256 bytes), you end with a sizeof(arracy_cache) = 
> 1024 bytes per cpu

A kbyte per cpu, for something 98% of systems will use -none- of.

Ouch.

All the more motivation for nuking cpuset_cache.

Patch coming in a minute.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
