Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316883AbSHGETS>; Wed, 7 Aug 2002 00:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316882AbSHGETR>; Wed, 7 Aug 2002 00:19:17 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:64222 "EHLO
	lists.samba.org") by vger.kernel.org with ESMTP id <S316880AbSHGETQ>;
	Wed, 7 Aug 2002 00:19:16 -0400
Date: Wed, 7 Aug 2002 14:18:29 +1000
From: Anton Blanchard <anton@samba.org>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andrew Morton <akpm@zip.com.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: fix CONFIG_HIGHPTE
Message-ID: <20020807041829.GD6343@krispykreme>
References: <20020807010752.GC6343@krispykreme> <Pine.LNX.4.44L.0208070104490.23404-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0208070104490.23404-100000@imladris.surriel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Sharing the logical page table doesn't mean you'll have to do
> the same for the PPC hashed page table...

We have an optimisation where we store information in the linux pte that
lets us find the hashtable pte. If that one to one relationship is lost
we may need to search the primary and secondary group which could be
up to 16 hypervisor calls when running in logical partitioned mode.

We could start sharing hashtable ptes but thats going to require a fair
amount of work.

Anton
