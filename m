Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265403AbTIDU6N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 16:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265496AbTIDU6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 16:58:13 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:21408 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265403AbTIDU6J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 16:58:09 -0400
Date: Thu, 04 Sep 2003 13:47:08 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Rik van Riel <riel@redhat.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scaling noise
Message-ID: <169120000.1062708428@flay>
In-Reply-To: <Pine.LNX.4.44.0309041634250.14715-100000@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.44.0309041634250.14715-100000@chimarrao.boston.redhat.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 3 Sep 2003, Martin J. Bligh wrote:
> 
>> The real core use of NUMA is to run one really big app on one machine,
>> where it's hard to split it across a cluster. You just can't build an
>> SMP box big enough for some of these things.
> 
> That only works when the NUMA factor is low enough that
> you can effectively treat the box as an SMP system.
> 
> It doesn't work when you have a NUMA factor of 15 (like
> some unspecified box you are very familiar with) and
> half of your database index is always on the "other half"
> of the two-node NUMA system.
> 
> You'll end up with half your accesses being 15 times as
> slow, meaning that your average memory access time is 8
> times as high!  Good way to REDUCE performance, but most
> people won't like that...
> 
> If the NUMA factor is low enough that applications can
> treat it like SMP, then the kernel NUMA support won't
> have to be very high either...

I think there's a few too many assumptions in that - are you thinking
of a big r/w shmem application? There's lots of other application
programming models that wouldn't suffer nearly so much ... but maybe
they're more splittable ... there's lots of things we can do to ensure
at least better than average node-locality for most of the memory.

M.

