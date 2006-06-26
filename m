Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932623AbWFZS1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623AbWFZS1A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 14:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbWFZS1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 14:27:00 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:56783 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932623AbWFZS07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 14:26:59 -0400
Message-ID: <44A026ED.8080903@sgi.com>
Date: Mon, 26 Jun 2006 11:26:53 -0700
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Shailabh Nagar <nagar@watson.ibm.com>, jlan@engr.sgi.com,
       balbir@in.ibm.com, csturtiv@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com>	<20060609010057.e454a14f.akpm@osdl.org>	<448952C2.1060708@in.ibm.com>	<20060609042129.ae97018c.akpm@osdl.org>	<4489EE7C.3080007@watson.ibm.com>	<449999D1.7000403@engr.sgi.com>	<44999A98.8030406@engr.sgi.com>	<44999F5A.2080809@watson.ibm.com>	<4499D7CD.1020303@engr.sgi.com>	<449C2181.6000007@watson.ibm.com>	<20060623141926.b28a5fc0.akpm@osdl.org>	<449C6620.1020203@engr.sgi.com>	<20060623164743.c894c314.akpm@osdl.org>	<449CAA78.4080902@watson.ibm.com>	<20060623213912.96056b02.akpm@osdl.org>	<449CD4B3.8020300@watson.ibm.com>	<44A01A50.1050403@sgi.com>	<20060626105548.edef4c64.akpm@osdl.org>	<44A020CD.30903@watson.ibm.com> <20060626111249.7aece36e.akpm@osdl.org>
In-Reply-To: <20060626111249.7aece36e.akpm@osdl.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Mon, 26 Jun 2006 14:00:45 -0400
> Shailabh Nagar <nagar@watson.ibm.com> wrote:
> 
> 
>>>Balbir, are you able to summarise where we stand wrt
>>>per-task-delay-accounting-* now?
>>> 
>>>
>>
>>Andrew,
>>
>>I'm maintaining per-task delay accouting and taskstats interface patches 
>>so I'll take the liberty to reply :-)
> 
> 
> Sorry, too many IBMers ;)
> 
> 
>>>What problem have we identified?  How close are we to finding agreeable
>>>solutions to them?
>>> 
>>>
>>
>>The main problems identified are:
>>
>>1. extra sending of per-tgid stats on every thread exit
>>2. unnecessary send of per-tgid stats when there are no listeners
>>3. unnecessary linkage of delayacct accumalation into per-tgid stats 
>>with sending out of taskstats
>>
>>All three have an acceptable solution.
>>1. & 3. are going to be addressed in a patch I'm sending out shortly.
>>2. in a separate patch also being sent out shortly.
> 
> 
> Great.
> 
> 
>>>My general sense is that there's some rework needed, and that rework will
>>>affect the userspace interfaces, which is a problem for a 2.6.18 merge.
>>> 
>>>
>>
>>The rework will affect the number of per-tgid records that userspace 
>>sees (fewer), not the format or any of the
>>other details regarding the genetlink interface.
>>Will that be a problem for userspace ?
> 
> 
> Nope.
> 
> OK, please send the patch and I'll plan on sending this lot to Linus
> Thursdayish.

These new patches are fresh out of Shailabh's stove (well, i have
seen one, but not the other yet) and i have not had chance to look
at them yet. No need to rush, does it?

- jay

> 

