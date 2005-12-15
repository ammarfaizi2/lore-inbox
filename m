Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751008AbVLOUMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbVLOUMg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 15:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbVLOUMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 15:12:36 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:12219 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750961AbVLOUMf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 15:12:35 -0500
To: Dave Hansen <haveblue@us.ibm.com>
cc: Hubertus Franke <frankeh@watson.ibm.com>, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, vserver@list.linux-vserver.org,
       Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       pagg@oss.sgi.com
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [ckrm-tech] Re: [RFC][patch 00/21] PID Virtualization: Overview and Patches 
In-reply-to: Your message of Thu, 15 Dec 2005 12:02:41 PST.
             <1134676961.22525.72.camel@localhost> 
Date: Thu, 15 Dec 2005 12:12:15 -0800
Message-Id: <E1EmzSZ-0007z2-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Dec 2005 12:02:41 PST, Dave Hansen wrote:
> On Thu, 2005-12-15 at 11:49 -0800, Gerrit Huizenga wrote:
> > I think perhaps this could also be the basis for a CKRM "class"
> > grouping as well.  Rather than maintaining an independent class
> > affiliation for tasks, why not have a class devolve (evolve?) into
> > a "container" as described here.
> 
> Wasn't one of the grand schemes of CKRM to be able to have application
> instances be shared?  For instance, running a single DB2, Oracle, or
> Apache server, and still accounting for all of the classes separately.
> If so, that wouldn't work with a scheme that requires process
> separation.
 
 Yes, it is.  However, that may be a sub-case where a single, large
 server application actually jumps around from container to container.
 I consider that a detail (well, our DB2 folks don't but I'm all for
 solving one problem at a time ;-) and we can work some of that out
 later.  They are less concerned about the application being shared
 or part of multiple "classes" simultaneously, as opposed to being
 appropriately resource contrained based on the (large) transactions
 that they are handling on behalf of a user.  So, if it were possible
 to jump from one container to another dynamically, then the appropriate
 resource management stuff could be handled at some other level.

> There might also be some serious restrictions on containerized
> applications.  For instance, taking a running application, moving it out
> of one container, and into another might not be feasible.  Is this
> something that is common or desired in the current CKRM framework?

 Desired, but primarily for large server applications.  And, I don't
 think I see much in this patch set that makes that infeasible.  If
 containers are going to work, you are going to have to have a mechanism
 to get applications into them and to move them anyway, right?  While
 it would be nice if that were dirt-cheap, if it isn't, applications
 may have to adapt their usage of them based on the cost.  Not a big
 deal as I see it.

gerrit
