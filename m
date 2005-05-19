Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbVESTD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVESTD0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 15:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVESTD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 15:03:26 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:23258 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261224AbVESTDV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 15:03:21 -0400
Message-ID: <428CE2EF.803@us.ibm.com>
Date: Thu, 19 May 2005 12:03:11 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <christoph@lameter.com>
CC: Dave Hansen <haveblue@us.ibm.com>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Jesse Barnes <jbarnes@virtuousgeek.org>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       shai@scalex86.org, steiner@sgi.com
Subject: Re: NUMA aware slab allocator V3
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com>  <Pine.LNX.4.62.0505161046430.1653@schroedinger.engr.sgi.com>  <714210000.1116266915@flay> <200505161410.43382.jbarnes@virtuousgeek.org>  <740100000.1116278461@flay>  <Pine.LNX.4.62.0505161713130.21512@graphe.net> <1116289613.26955.14.camel@localhost> <428A800D.8050902@us.ibm.com> <Pine.LNX.4.62.0505171648370.17681@graphe.net> <428B7B16.10204@us.ibm.com> <Pine.LNX.4.62.0505181046320.20978@schroedinger.engr.sgi.com> <428BB05B.6090704@us.ibm.com> <Pine.LNX.4.62.0505181439080.10598@graphe.net> <Pine.LNX.4.62.0505182105310.17811@graphe.net>
In-Reply-To: <Pine.LNX.4.62.0505182105310.17811@graphe.net>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Wed, 18 May 2005, Christoph Lameter wrote:
> 
>>Fixes to the slab allocator in 2.6.12-rc4-mm2
>>- Remove MAX_NUMNODES check
>>- use for_each_node/cpu
>>- Fix determination of INDEX_AC
> 
> Rats! The whole thing with cpu online and node online is not as easy as I 
> thought. There may be bugs in V3 of the numa slab allocator 
> because offline cpus and offline are not properly handled. Maybe 
> that also contributed to the ppc64 issues. 

Running this test through the "wringer" (aka building/booting on one of our
PPC64 boxen).  I'll let you know if this fixes any problems.


> The earlier patch fails if I boot an x86_64 NUMA kernel on a x86_64 single 
> processor system.
> 
> Here is a revised patch. Would be good if someone could review my use 
> of online_cpu / online_node etc. Is there some way to bring cpus 
> online and offline to test if this really works? Seems that the code in 
> alloc_percpu is suspect even in the old allocator because it may have
> to allocate memory for non present cpus.

I'll look through and see what I can tell you, but I gotta run to a meeting
now. :(

-Matt

