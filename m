Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262154AbSJOAgO>; Mon, 14 Oct 2002 20:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262245AbSJOAgO>; Mon, 14 Oct 2002 20:36:14 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:47303 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262154AbSJOAgN>;
	Mon, 14 Oct 2002 20:36:13 -0400
Message-ID: <3DAB6385.9000207@us.ibm.com>
Date: Mon, 14 Oct 2002 17:38:29 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       LSE <lse-tech@lists.sourceforge.net>, Andrew Morton <akpm@zip.com.au>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [rfc][patch] Memory Binding API v0.3 2.5.41
References: <3DAB5DF2.5000002@us.ibm.com> <2004595005.1034616026@[10.10.2.3]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>>4) An ordered zone list is probably the more natural mapping.
>>
>>See my comments above about per zone/memblk.  And you reemphasize my point, how do we order the zone lists in such a way that a user of the API can easily know/find out what zone #5 is?
> Could you explain how that problem is different from finding out
> what memblk #5 is ... I don't see the difference?
Errm...  __memblk_to_node(5)

I"m not saying that we couldn't add a similar interface for zones... 
something along the lines of:
	__memblk_and_zone_to_flat_zone_number(5, DMA)
or some such.  It just isn't there now...

Also, right now, memblks map to nodes in a straightforward manner (1-1 
on NUMA-Q, the only architecture that has defined them).  It will likely 
look the same on most architectures, too.

Cheers!

-Matt

