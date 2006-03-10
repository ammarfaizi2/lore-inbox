Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751752AbWCJGFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbWCJGFq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 01:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbWCJGFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 01:05:46 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:9616 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751388AbWCJGFq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 01:05:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ShXVq69moPc+wCtZejAP84ftIm2SS2fAbgJ0JxHi1JOXwmYzVBuG90pzRSwHnwxZuflmlIVm+w3Y7j2y2fSmf+ppYKACr5Bis7i4BgdrVE6D6C2nDjf2aRbIDXjXiHBYbx4r1rhiv3PFVERkb5Dg17/lrMmUWh7JgPFNYfIhvVM=
Message-ID: <aec7e5c30603092204h21fa7639wf90e6d4e2fdee128@mail.gmail.com>
Date: Fri, 10 Mar 2006 15:04:15 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH 03/03] Unmapped: Add guarantee code
Cc: "Magnus Damm" <magnus@valinux.co.jp>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <44110727.802@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060310034412.8340.90939.sendpatchset@cherry.local>
	 <20060310034429.8340.61997.sendpatchset@cherry.local>
	 <44110727.802@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> Magnus Damm wrote:
> > Implement per-LRU guarantee through sysctl.
> >
> > This patch introduces the two new sysctl files "node_mapped_guar" and
> > "node_unmapped_guar". Each file contains one percentage per node and tells
> > the system how many percentage of all pages that should be kept in RAM as
> > unmapped or mapped pages.
> >
>
> The whole Linux VM philosophy until now has been to get away from stuff
> like this.

Yeah, and Linux has never supported memory resource control either, right?

> If your app is really that specialised then maybe it can use mlock. If
> not, maybe the VM is currently broken.
>
> You do have a real-world workload that is significantly improved by this,
> right?

Not really, but I think there is a demand for memory resource control today.

The memory controller in ckrm also breaks out the LRU, but puts one
LRU instance in each class. My code does not depend on ckrm, but it
should be possible to have some kind of resource control with this
patch and cpusets. And yeah, add numa emulation if you are out of
nodes. =)

Thanks,

/ magnus
