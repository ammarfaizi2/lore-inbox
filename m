Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263525AbTICQYY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 12:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263440AbTICQXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 12:23:39 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:47242 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S263525AbTICQWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 12:22:31 -0400
Date: Wed, 03 Sep 2003 09:21:47 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scaling noise
Message-ID: <31570000.1062606101@[10.10.2.4]>
In-Reply-To: <20030903160133.GA23538@wohnheim.fh-wedel.de>
References: <E19uQsT-0007mk-00@calista.inka.de> <1062590946.19059.18.camel@dhcp23.swansea.linux.org.uk> <25950000.1062601832@[10.10.2.4]> <20030903160133.GA23538@wohnheim.fh-wedel.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The real core use of NUMA is to run one really big app on one machine, 
>> where it's hard to split it across a cluster. You just can't build an 
>> SMP box big enough for some of these things.
> 
> This "hard to split" is usually caused by memory use instead of cpu
> use, right?

Heavy process intercommunication I guess, often but not always through
shared mem.
 
> I don't see a big problem scaling number crunchers over a cluster, but
> a process with a working set >64GB cannot be split between 4GB
> machines easily.

Right - some problems split nicely, and should get run on clusters because
it's a shitload cheaper. Preferably an SSI cluster so you get to manage
things easily, but either way. As you say, some things just don't split
that way, and that's why people pay for big iron (which ends up being
NUMA). 

I've seen people use big machines for clusterable things, which I think
is a waste of money, but the cost of the machine compared to the cost
of admin (vs multiple machines) may have come down to the point where 
it's worth it now. You get implicit "cluster" load balancing done in a
transparent way by the OS on NUMA boxes.

M.

