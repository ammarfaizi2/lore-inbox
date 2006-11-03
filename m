Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752917AbWKCBaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917AbWKCBaB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 20:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752922AbWKCBaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 20:30:01 -0500
Received: from mx3.cs.washington.edu ([128.208.3.132]:729 "EHLO
	mx3.cs.washington.edu") by vger.kernel.org with ESMTP
	id S1752917AbWKCB37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 20:29:59 -0500
Date: Thu, 2 Nov 2006 17:29:32 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: Pavel Emelianov <xemul@openvz.org>
cc: vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com, menage@google.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com, devel@openvz.org
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
In-Reply-To: <4549AF81.2060706@openvz.org>
Message-ID: <Pine.LNX.4.64N.0611021714080.12501@attu4.cs.washington.edu>
References: <20061030103356.GA16833@in.ibm.com> <45460743.8000501@openvz.org>
 <20061031163418.GD9588@in.ibm.com> <4548545B.4070701@openvz.org>
 <20061101175015.GA22976@in.ibm.com> <4549AF81.2060706@openvz.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2006, Pavel Emelianov wrote:

> So if we're going to have different groupings for different
> resources what's the use of "container" grouping all "controllers"
> together? I see this situation like each task_struct carries
> pointers to kmemsize controller, pivate pages controller,
> physical pages controller, CPU time controller, disk bandwidth
> controller, etc. Right? Or did I miss something?

My understanding is that the only addition to the task_struct is a pointer 
to the struct container it belongs to.  Then, the various controllers can 
register the control files through the fs-based container interface and 
all the manipulation can be done at that level.  Having each task_struct 
containing pointers to individual resource nodes was never proposed.

		David
