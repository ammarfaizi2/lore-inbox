Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266196AbUIXELm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266196AbUIXELm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 00:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266073AbUIXELm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 00:11:42 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:44943 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266196AbUIXELj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 00:11:39 -0400
Message-ID: <41539EC1.1040301@sgi.com>
Date: Thu, 23 Sep 2004 23:12:49 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Ray Bryant <raybry@austin.rr.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, linux-mm <linux-mm@kvack.org>,
       Jesse Barnes <jbarnes@sgi.com>, Dan Higgins <djh@sgi.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Brent Casavant <bcasavan@sgi.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, Paul Jackson <pj@sgi.com>,
       Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [PATCH 1/2] mm: page cache mempolicy for page cache allocation
References: <20040923043236.2132.2385.23158@raybryhome.rayhome.net> <20040923043246.2132.91877.24290@raybryhome.rayhome.net> <20040923092416.GC6146@wotan.suse.de>
In-Reply-To: <20040923092416.GC6146@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> 
> Overall when I look at all the complications you add for the per process
> page policy which doesn't even have a demonstrated need I'm not sure
> it is really worth it.
>


Polling people inside of SGI, they seem to think that a per file memory policy
is a good thing, but it needs to be settable from outside the process without
changing the header or code of the process (think of an ISV application that
we want to run on Altix.)  I can't quite get my head around what that means
(do you have to specify this externally based on the order that files are
opened in [e. g. file 1 has policy this, file 2 has policy that, etc] or does
one specify this by type of file [text, mapped file, etc]).  Does this end up
being effectively a per process policy with a per file override?  (e. g. all
files for this process are managed with policy "this", except for the 5th file
opened [or whatever] and it has policy "that".)

Steve -- how does your MTA design handle this?

Anyway, I'm about to throw in the towel on the per process page cache memory
policy.  I can't make a strong enough argument for it.

I assume that is acceptable, Andi?  :-)
-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------

