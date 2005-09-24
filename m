Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbVIXMx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbVIXMx1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 08:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbVIXMx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 08:53:27 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:34453 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1750744AbVIXMx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 08:53:26 -0400
Message-ID: <43354C0E.5050001@colorfullife.com>
Date: Sat, 24 Sep 2005 14:52:30 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.10) Gecko/20050909 Fedora/1.7.10-1.5.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alok Kataria <alokk@calsoftinc.com>
CC: Christoph Lameter <clameter@engr.sgi.com>,
       Petr Vandrovec <vandrove@vc.cvut.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
References: <433458B6.7000008@calsoftinc.com>
In-Reply-To: <433458B6.7000008@calsoftinc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alok Kataria wrote:

>
> IMO the slab->nodeid  field just lets us know to which nodes list3 is 
> this slab attached, irrespective of the node from
> which node the memory was got.
>
Correct. Otherwise the code wouldn't work on ia32 NUMAQ systems: They 
have the whole ZONE_NORMAL in node 0.
When a slab is allocated, it's assigned to the node that did the alloc, 
regardless of the physical location of the memory.

--
    Manfred
