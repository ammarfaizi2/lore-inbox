Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbTICQD4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 12:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263683AbTICQDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 12:03:30 -0400
Received: from [213.39.233.138] ([213.39.233.138]:28842 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263440AbTICQBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 12:01:47 -0400
Date: Wed, 3 Sep 2003 18:01:33 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scaling noise
Message-ID: <20030903160133.GA23538@wohnheim.fh-wedel.de>
References: <E19uQsT-0007mk-00@calista.inka.de> <1062590946.19059.18.camel@dhcp23.swansea.linux.org.uk> <25950000.1062601832@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25950000.1062601832@[10.10.2.4]>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 September 2003 08:10:33 -0700, Martin J. Bligh wrote:
> 
> > multi node yes, numa not much and where numa-like systems are being used
> > they are being used for message passing not as a fake big pc. 
> > 
> > Numa is valuable because
> > - It makes some things go faster without having to rewrite them
> > - It lets you partition a large box into several effective small ones 
> >   cutting maintenance
> > - It lets you partition a large box into several effective small ones
> >   so you can avoid buying two software licenses for expensive toys
> > 
> > if you actually care enough about performance to write the code to do
> > the job then its value is rather questionable. There are exceptions as
> > with anything else.
> 
> The real core use of NUMA is to run one really big app on one machine, 
> where it's hard to split it across a cluster. You just can't build an 
> SMP box big enough for some of these things.

This "hard to split" is usually caused by memory use instead of cpu
use, right?

I don't see a big problem scaling number crunchers over a cluster, but
a process with a working set >64GB cannot be split between 4GB
machines easily.

Jörn

-- 
Good warriors cause others to come to them and do not go to others.
-- Sun Tzu
