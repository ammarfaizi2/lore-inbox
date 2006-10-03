Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWJCMNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWJCMNp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 08:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWJCMNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 08:13:45 -0400
Received: from gate.crashing.org ([63.228.1.57]:46255 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750747AbWJCMNp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 08:13:45 -0400
Subject: Re: 2.6.18-rc6-mm2: fix for error compiling ppc/mm/init.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mel Gorman <mel@csn.ul.ie>
Cc: Judith Lebzelter <judith@osdl.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Paul Mackerras <paulus@samba.org>
In-Reply-To: <Pine.LNX.4.64.0610031023100.13141@skynet.skynet.ie>
References: <20060914173705.GC19807@shell0.pdx.osdl.net>
	 <Pine.LNX.4.64.0609141910440.1812@skynet.skynet.ie>
	 <1159849491.5482.24.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0610030909490.2904@skynet.skynet.ie>
	 <1159867180.5482.61.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0610031023100.13141@skynet.skynet.ie>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 22:12:32 +1000
Message-Id: <1159877552.5482.69.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Once we have a patch using symbolic names working on ppc, I'll make a 
> patch that uses symbolic names on the other architectures and post it.

Ok, good :) I don't like magic numbers

> I don't know if it has been fixed either.

Yeah... I'm not in a mood to audit all of that for 2.6.19, so I'd rather
keep it the way it is for now.

> Once we get ppc sorted, I'll make a patch that uses explicit array 
> initialisation and symbolic index names on the other arches.

Ok. Any reason why my current patch wouldn't be good then ? If it's ok
for you, I'll put it in paulus queue for merging.

> I believe it was to stop having more empty zones than was really 
> necessary. It was a saving on NUMA. I might be wrong, I'll need to check 
> the archives again.

Well, as long as we use named indices in the array and make sure it's
properly initialized to 0, that should be ok.

> You're right. The generic code does handle this case because at one point, 
> I remembered clearly that not all zones would be in use :/

Good then :)

Cheers,
Ben.


