Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293043AbSCEANw>; Mon, 4 Mar 2002 19:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293040AbSCEANk>; Mon, 4 Mar 2002 19:13:40 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:12305 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S293043AbSCEAMh>;
	Mon, 4 Mar 2002 19:12:37 -0500
Date: Mon, 4 Mar 2002 21:12:25 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Stephan von Krawczynski <skraw@ithnet.com>, <phillips@bonn-fries.net>,
        <davidsen@tmr.com>, <mfedyk@matchmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19pre1aa1
In-Reply-To: <20020304230603.O20606@dualathlon.random>
Message-ID: <Pine.LNX.4.44L.0203042111150.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Mar 2002, Andrea Arcangeli wrote:
> On Mon, Mar 04, 2002 at 10:46:54AM -0800, Martin J. Bligh wrote:

> > seems to me to be that the way we do current swap-out scanning is virtual,
> > not physical, and thus cannot be per zone => per node.
>
> actually if you do process bindings the pte should be all allocated
> local to the node if numa is enabled, and if there's no binding, no
> matter if you have rmap or not, the ptes can be spread across the whole
> system (just like the physical pages in the inactive/active lrus,
> because they're not per-node).

Think shared pages.

With -rmap you'll scan all the page table entries mapping
the pages on the current node, regardless of which node
the page tables live.

Without -rmap you'll need to scan all page table entries
in the system, not just the ones mapping pages on the
current node.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

