Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbTLAJrG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 04:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbTLAJrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 04:47:06 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:54674 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S262738AbTLAJrD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 04:47:03 -0500
To: =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Jack Steiner <steiner@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: hash table sizes
References: <16323.23221.835676.999857@gargle.gargle.HOWL>
	<20031125204814.GA19397@sgi.com>
	<20031125130741.108bf57c.akpm@osdl.org>
	<20031125211424.GA32636@sgi.com>
	<20031125132439.3c3254ff.akpm@osdl.org>
	<yq0d6bcmvfd.fsf@wildopensource.com> <20031128145255.GA26853@sgi.com>
	<yq08ym0mpig.fsf@wildopensource.com> <20031128193536.GA28519@sgi.com>
	<20031128211827.GA25644@wohnheim.fh-wedel.de>
From: Jes Sorensen <jes@wildopensource.com>
Date: 01 Dec 2003 04:46:22 -0500
In-Reply-To: <20031128211827.GA25644@wohnheim.fh-wedel.de>
Message-ID: <yq0ptf898gh.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jörn" == Jörn Engel <joern@wohnheim.fh-wedel.de> writes:

Jörn> [pruned CC: list]
Jörn> On Fri, 28 November 2003 13:35:36 -0600, Jack Steiner wrote:
>> You proposed above to limit the allocation to the amount of memory
>> on a node.

Jörn> Jes didn't _limit_ the allocation to the memory on a node, he
Jörn> _based_ it on it, instead of total memory for all nodes.
Jörn> Therefore a 1024 node NUMA machine with 2GB per node has no
Jörn> bigger hash tables, than a single CPU machine with 2GB total
Jörn> memory, however big that may be.

Jörn> Unless I didn't understand his patch, that is. :)

Yep, thats exactly what my patch did. There's a gotcha if node 0 has a
lot less memory than the remaining nodes, but I also suspect the size
of those hash tables was already out of whack as memory has gone up.

Thanks,
Jes
