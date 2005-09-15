Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965213AbVIOHUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965213AbVIOHUs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 03:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965203AbVIOHUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 03:20:48 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:18147 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S965196AbVIOHUq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 03:20:46 -0400
Message-ID: <4329210E.4070806@aitel.hist.no>
Date: Thu, 15 Sep 2005 09:21:50 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@mbligh.org>
CC: Andi Kleen <ak@suse.de>, David Chinner <dgc@sgi.com>,
       Bharata B Rao <bharata@in.ibm.com>, "Theodore Ts'o" <tytso@mit.edu>,
       Dipankar Sarma <dipankar@in.ibm.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: VM balancing issues on 2.6.13: dentry cache not getting shrunk
 enough
References: <20050911105709.GA16369@thunk.org> <20050913084752.GC4474@in.ibm.com> <20050913215932.GA1654338@melbourne.sgi.com> <200509141101.16781.ak@suse.de> <313480000.1126706276@[10.10.2.4]>
In-Reply-To: <313480000.1126706276@[10.10.2.4]>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:

>
>If they're freeable, we should easily be able to move them, and therefore 
>compact a fragmented slab. That way we can preserve the LRU'ness of it.
>Stage 1: free the oldest entries. Stage 2: compact the slab into whole
>pages. Stage 3: free whole pages back to teh page allocator.
>  
>
That seems like the perfect solution to me.  Freeing up 95% or more
gives us clean pages - and moving instead of actually freeing
everything avoids the cost of repopulating the cache later. :-)

Helge Hafting
