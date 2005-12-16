Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbVLPUqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbVLPUqO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 15:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbVLPUqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 15:46:14 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:36540 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932405AbVLPUqN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 15:46:13 -0500
To: Dave Hansen <haveblue@us.ibm.com>
cc: Matt Helsley <matthltc@us.ibm.com>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, vserver@list.linux-vserver.org,
       Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       pagg@oss.sgi.com
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [ckrm-tech] Re: [RFC][patch 00/21] PID Virtualization: Overview and Patches 
In-reply-to: Your message of Fri, 16 Dec 2005 09:35:19 PST.
             <1134754519.19403.6.camel@localhost> 
Date: Fri, 16 Dec 2005 12:45:42 -0800
Message-Id: <E1EnMSU-0004pH-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Dec 2005 09:35:19 PST, Dave Hansen wrote:
> On Thu, 2005-12-15 at 19:28 -0800, Gerrit Huizenga wrote:
> > In the pid virtualization, I would think that tasks can move between
> > containers as well,
> 
> I don't think tasks can not be permitted to move between containers.  As
> a simple exercise, imagine that you have two processes with the same
> pid, one in container A and one in container B.  You wish to have them
> both run in container A.  They can't both have the same pid.  What do
> you do?
> 
> I've been talking a lot lately about how important filesystem isolation
> between containers is to implement containers properly.  Isolating the
> filesystem namespaces makes it much easier to do things like fs-based
> shared memory during a checkpoint/resume.  If we want to allow tasks to
> move around, we'll have to throw out this entire concept.  That means
> that a _lot_ of things get a notch closer to the too-costly-to-implement
> category.

Interesting...  So how to tasks get *into* a container?  And can they
ever get back "out" of a container?  Are most processes on the system
initially not in a container?  And then they can be stuffed in a container?
And then containers can be moved around or be isolated from each other?

And, is pid virtualization the point where this happens?  Or is that
a slightly higher level?  In other words, is pid virtualization the
full implementation of container isolation?  Or is it a significant
element on which additional policy, restrictions, and usage models
can be built?

gerrit
