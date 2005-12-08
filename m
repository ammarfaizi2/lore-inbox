Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030459AbVLHFFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030459AbVLHFFY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 00:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030460AbVLHFFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 00:05:24 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:44215 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030459AbVLHFFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 00:05:23 -0500
Message-ID: <4397BE6D.9070303@jp.fujitsu.com>
Date: Thu, 08 Dec 2005 14:02:37 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] Re: [PATCH] swap migration: Fix lru drain
References: <Pine.LNX.4.62.0512071351010.25527@schroedinger.engr.sgi.com> <20051207161319.6ada5c33.akpm@osdl.org> <Pine.LNX.4.62.0512071635250.26288@schroedinger.engr.sgi.com> <20051207165730.02dc591e.akpm@osdl.org> <Pine.LNX.4.62.0512071706001.26471@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0512071706001.26471@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Wed, 7 Dec 2005, Andrew Morton wrote:
> 
> 
>>I'll change this to return 0 on success, or -ENOMEM.  Bit more
>>conventional, no?
> 
> 
> Ok. That also allows the addition of other error conditions in the future.
> Need to revise isolate_lru_page to reflect that.
> 
I think this 'schedule_on_each_cpu(lru_add_drain_per_cpu, NULL);' will be used
by memory-hot-removing code and some other codes.
How about move this to swap.c and name as 'lru_add_drain_all()' ?
(but there is no other users now....)

-- Kame

