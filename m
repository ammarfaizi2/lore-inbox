Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWCJPmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWCJPmE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 10:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751592AbWCJPmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 10:42:04 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:14214 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751085AbWCJPmD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 10:42:03 -0500
Subject: Re: [PATCH 03/03] Unmapped: Add guarantee code
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Magnus Damm <magnus@valinux.co.jp>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Valerie Clement <Valerie.Clement@bull.net>
In-Reply-To: <aec7e5c30603092204h21fa7639wf90e6d4e2fdee128@mail.gmail.com>
References: <20060310034412.8340.90939.sendpatchset@cherry.local>
	 <20060310034429.8340.61997.sendpatchset@cherry.local>
	 <44110727.802@yahoo.com.au>
	 <aec7e5c30603092204h21fa7639wf90e6d4e2fdee128@mail.gmail.com>
Content-Type: text/plain
Organization: IBM
Date: Fri, 10 Mar 2006 07:41:17 -0800
Message-Id: <1142005277.8174.107.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 15:04 +0900, Magnus Damm wrote:
> On 3/10/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> > Magnus Damm wrote:
> > > Implement per-LRU guarantee through sysctl.
> > >
> > > This patch introduces the two new sysctl files "node_mapped_guar" and
> > > "node_unmapped_guar". Each file contains one percentage per node and tells
> > > the system how many percentage of all pages that should be kept in RAM as
> > > unmapped or mapped pages.
> > >
> >
> > The whole Linux VM philosophy until now has been to get away from stuff
> > like this.
> 
> Yeah, and Linux has never supported memory resource control either, right?
> 
> > If your app is really that specialised then maybe it can use mlock. If
> > not, maybe the VM is currently broken.
> >
> > You do have a real-world workload that is significantly improved by this,
> > right?
> 
> Not really, but I think there is a demand for memory resource control today.

As a person who is working on CKRM, I totally agree with this :)

> 
> The memory controller in ckrm also breaks out the LRU, but puts one
> LRU instance in each class. My code does not depend on ckrm, but it
> should be possible to have some kind of resource control with this

i do not understand how breaking lru lists into mapped/unmapped pages
and providing a knob to control the proportion of mapped/unmapped pages
in a node help in resource control.

Can you explain, please. I am very interested.

> patch and cpusets. And yeah, add numa emulation if you are out of
> nodes. =)
> 
> Thanks,
> 
> / magnus
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


