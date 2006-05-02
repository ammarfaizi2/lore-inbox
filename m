Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWEBUMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWEBUMU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 16:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWEBUMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 16:12:20 -0400
Received: from ns.suse.de ([195.135.220.2]:17627 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932161AbWEBUMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 16:12:19 -0400
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
Date: Tue, 2 May 2006 22:12:13 +0200
User-Agent: KMail/1.9.1
Cc: Martin Bligh <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
References: <20060419112130.GA22648@elte.hu> <200605022200.12980.ak@suse.de> <20060502201358.GA10831@elte.hu>
In-Reply-To: <20060502201358.GA10831@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605022212.13842.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 May 2006 22:13, Ingo Molnar wrote:

> nah. And the fact that i could boot this on a non-NUMA box already 
> unearthed a weakness in the buddy allocator. (it should have much 
> clearer asserts about mis-sized zones - it's not the first time we had 
> them and they are hard to debug) 

GIGO.

> So consider this a debugging feature.  
> It also found other bugs, so even if nobody but me uses it, it's useful.

It's an awful lot of ugly code for a debugging feature.

Also I never considered i386 NUMA to be particularly interesting 
because it doesn't work for the kernel lowmem which is always on node 0.
So no matter what you try you have a nasty hotspot on node 0's memory.

-Andi
