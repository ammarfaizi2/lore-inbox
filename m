Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266181AbUJHW5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266181AbUJHW5R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 18:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266186AbUJHWzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 18:55:06 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:11226 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S266189AbUJHWxV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 18:53:21 -0400
Subject: Re: [Lse-tech] [RFC PATCH] scheduler: Dynamic sched_domains
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Erich Focht <efocht@hpce.nec.com>,
       LSE Tech <lse-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       ckrm-tech@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>,
       simon.derr@bull.net, frankeh@watson.ibm.com
In-Reply-To: <41670CFC.1020306@bigpond.net.au>
References: <1097110266.4907.187.camel@arrakis>
	 <200410081214.20907.efocht@hpce.nec.com> <41666E90.2000208@yahoo.com.au>
	 <1097261691.5650.23.camel@arrakis>  <41670CFC.1020306@bigpond.net.au>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1097275938.6470.97.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 08 Oct 2004 15:52:18 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-08 at 14:56, Peter Williams wrote:
> > How do we describe the levels other than the first?  We'd either need
> > to:
> > 1) come up with a language to describe the full tree.  For your example
> > I quoted above:
> >    echo "0,1,2,4,5 3,6 7,8;0,1,2 4,5 3 6,7;0,1 2 4,5 3 6,7" > partitions
> 
> I think the idea was that the full hierarchy was (automatically) derived 
> from the partition in a way that best matched the physical layout of the 
> machine?

Absolutely.  I mentioned that in a different response in this thread. 
The default behavior on boot up should be for the
arch_init_sched_domains() to build a sched_domains hierarchy that
mirrors the physical layout of the machine for maximal scheduling
efficiency for general computing.  If the users/admin of the machine
want to configure the machine for a particular type(s) of workload, then
they can do that through the soon-to-be-figured-out API to rebuild the
sched_domains hierarchy in their own image and likeness...

-Matt

