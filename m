Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbVLQDDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbVLQDDf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 22:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbVLQDDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 22:03:35 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:5607 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751363AbVLQDDf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 22:03:35 -0500
Subject: Re: [Lse-tech] Re: [ckrm-tech] Re: [RFC][patch 00/21] PID
	Virtualization: Overview and Patches
From: Hubertus Franke <frankeh@watson.ibm.com>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, vserver@list.linux-vserver.org,
       Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       pagg@oss.sgi.com
In-Reply-To: <1134782298.10396.337.camel@stark>
References: <E1En6H2-0005ok-00@w-gerrit.beaverton.ibm.com>
	 <1134754519.19403.6.camel@localhost>
	 <1134776864.28779.19.camel@elg11.watson.ibm.com>
	 <1134782298.10396.337.camel@stark>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 22:03:32 -0500
Message-Id: <1134788612.28779.45.camel@elg11.watson.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-22) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-16 at 17:18 -0800, Matt Helsley wrote:
> On Fri, 2005-12-16 at 18:47 -0500, Hubertus Franke wrote:
> > On Fri, 2005-12-16 at 09:35 -0800, Dave Hansen wrote:
> <snip>
> > > I've been talking a lot lately about how important filesystem isolation
> > > between containers is to implement containers properly.  Isolating the
> > > filesystem namespaces makes it much easier to do things like fs-based
> > > shared memory during a checkpoint/resume.  If we want to allow tasks to
> > > move around, we'll have to throw out this entire concept.  That means
> > > that a _lot_ of things get a notch closer to the too-costly-to-implement
> > > category.
> > > 
> > 
> > Not only that, as the example of pids already show, while at the surface
> > these might seem as desirable features ( particular since they came up
> > wrt to the CKRM discussion ), there are significant technical limitation
> > to these. 
> 
> 	Perhaps merging the container process grouping functionality is not a
> good idea. 
> 
> 	However, I think CKRM could be made minimally consistent with
> containers using a few small modifications. I suspect all that is
> necessary is:
> 
<snip>
> 	I think this would be sufficient to make CKRM and containers play
> nicely with each other. I suspect further kernel-enforced constraints
> between CKRM and containers may constitute policy and not functionality.
> 

I think that as a first step mutual coexistence is already quite
useful. 
Once I containerize applications, having the ability to actually
constrain and manage the resources consumed by that application would
be a real plus. In that sense a container and CKRM class coincide.
So even enforcing that "alignment" at a higher level through some 
awareness in the classification engine for instance would be quite
useful. Are they the same kernel object .. NO .. because of the 
life cycle management of a process, namely once moved into a container
it stays there...


> 
> Cheers,
> 	-Matt Helsley

Prost ...

Hubertus Franke <frankeh@watson.ibm.com>

