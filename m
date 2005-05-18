Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVERR2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVERR2E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 13:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbVERR2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 13:28:04 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:63458 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261345AbVERR15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 13:27:57 -0400
Message-ID: <428B7B16.10204@us.ibm.com>
Date: Wed, 18 May 2005 10:27:50 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <christoph@lameter.com>
CC: Dave Hansen <haveblue@us.ibm.com>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Jesse Barnes <jbarnes@virtuousgeek.org>,
       Christoph Lameter <clameter@engr.sgi.com>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       shai@scalex86.org, steiner@sgi.com
Subject: Re: NUMA aware slab allocator V3
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com>  <Pine.LNX.4.62.0505161046430.1653@schroedinger.engr.sgi.com>  <714210000.1116266915@flay> <200505161410.43382.jbarnes@virtuousgeek.org>  <740100000.1116278461@flay>  <Pine.LNX.4.62.0505161713130.21512@graphe.net> <1116289613.26955.14.camel@localhost> <428A800D.8050902@us.ibm.com> <Pine.LNX.4.62.0505171648370.17681@graphe.net>
In-Reply-To: <Pine.LNX.4.62.0505171648370.17681@graphe.net>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Tue, 17 May 2005, Matthew Dobson wrote:
> 
> 
>>You're right, Dave.  The series of #defines at the top resolve to the same
>>thing as numa_node_id().  Adding the above #defines will serve only to
>>obfuscate the code.
> 
> 
> Ok.
>  
> 
>>Another thing that will really help, Christoph, would be replacing all your
>>open-coded for (i = 0; i < MAX_NUMNODES/NR_CPUS; i++) loops.  We have
>>macros that make that all nice and clean and (should?) do the right thing
>>for various combinations of SMP/DISCONTIG/NUMA/etc.  Use those and if they
>>DON'T do the right thing, please let me know and we'll fix them ASAP.
> 
> 
> Some of that was already done but I can check again.

Thanks!  I just looked at V2 & V3 of the patch and saw some open-coded
loops.  I may have missed a later version of the patch which has fixes.
Feel free to CC me on future versions of the patch...

-Matt
