Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289032AbSA3J54>; Wed, 30 Jan 2002 04:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289036AbSA3J5q>; Wed, 30 Jan 2002 04:57:46 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:9993 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S289032AbSA3J5i>;
	Wed, 30 Jan 2002 04:57:38 -0500
Message-ID: <3C57C38B.30101@namesys.com>
Date: Wed, 30 Jan 2002 12:57:31 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020123
X-Accept-Language: en-us
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
CC: Chris Mason <mason@suse.com>, Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        linux-kernel <linux-kernel@vger.kernel.org>, reiserfs-list@namesys.com,
        reiserfs-dev@namesys.com
Subject: Re: [reiserfs-dev] Re: Note describing poor dcache utilization under high memory pressure
In-Reply-To: <Pine.LNX.4.44.0201300106020.25123-100000@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:

>
>Can we get you to agree that basically all subpage objects are immovable?
>
No.  Certainly not in the general case, and I think Josh found ways to 
handle the dcache case.  If we can simply free the old objects, we don't 
actually have to move the hot ones, as he points out.

>
>And as a consequence that garbage collecting at subpage levels doesn't
>guarantee freeing up any pages that can then be given up to other
>subsystems in response to VM pressure? The GC must think in terms of pages
>to actually make progress.
>
>One of the design goals of slab by the way is that objects of a similar
>type will end up having similar lifetimes, avoiding some of the worst
>cases of sub-page allocations.
>



