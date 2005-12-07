Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbVLGLeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbVLGLeS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 06:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbVLGLeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 06:34:18 -0500
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:59988 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1750896AbVLGLeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 06:34:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=us4HIAivuoq9D693DKY2CENfBaIChK9JWJlT4HcKMHuoEeYFjWZEsO7CYZUNH1MX+POrfTj6do3J0s99xgBHsJLCnrWXVJI+81gI/QTfehi3NVfPhCHgphEACnVjwb8xkyC0LkMery/ARlBSUz1dgnX2XPPwhzFKPkfZ6S7NeFM=  ;
Message-ID: <4396C8B3.1020908@yahoo.com.au>
Date: Wed, 07 Dec 2005 22:34:11 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Magnus Damm <magnus.damm@gmail.com>, Nick Piggin <npiggin@suse.de>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH 06/16] mm: balance slab aging
References: <20051207104755.177435000@localhost.localdomain> <20051207105019.800865000@localhost.localdomain> <20051207110840.GC7570@mail.ustc.edu.cn>
In-Reply-To: <20051207110840.GC7570@mail.ustc.edu.cn>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang wrote:
> A question about the current one:
> 
> For a NUMA system with N nodes, the way kswapd calculates lru_pages - only sum
> up local zones - may cause N times more shrinking than a 1-CPU system.
> 

But it is equal pressure for all pools involved in being scaned the
simplifying assumption is that slab is equally distributed among
nodes. And yeah, scanning would load up when more than 1 kswapd is
running.

I had patches to do per-zone inode and dentry slab shrinking ages
ago, but nobody was interested... so I'm guessing it is a feature :)

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
