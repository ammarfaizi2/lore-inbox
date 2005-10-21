Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965004AbVJUQBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbVJUQBK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 12:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbVJUQBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 12:01:10 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:61088 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965004AbVJUQBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 12:01:08 -0400
Date: Fri, 21 Oct 2005 09:00:56 -0700
From: mike kravetz <kravetz@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, clameter@sgi.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, magnus.damm@gmail.com, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 0/4] Swap migration V3: Overview
Message-ID: <20051021160056.GA32741@w-mikek2.ibm.com>
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com> <20051020160638.58b4d08d.akpm@osdl.org> <20051020234621.GL5490@w-mikek2.ibm.com> <20051021082849.45dafd27.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051021082849.45dafd27.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2005 at 08:28:49AM -0700, Paul Jackson wrote:
> Mike wrote:
> > Just to be clear, there are at least two distinct requirements for hotplug.
> > One only wants to remove a quantity of memory (location unimportant). 
> 
> Could you describe this case a little more?  I wasn't aware
> of this hotplug requirement, until I saw you comment just now.

Think of a system running multiple OS's on top of a hypervisor, where
each OS is given some memory for exclusive use.  For multiple reasons
(one being workload management) it is desirable to move resources from
one OS to another.  For example, take memory away from an underutilized
OS and give it to an over utilized OS.

This describes the environment on IBM's mid to upper level POWER systems.
Currently, there is OS support to dynamically move/reassign CPUs and
adapters between different OSs on these systems.

My knowledge of Xen is limited, but this might also apply to that
environment also.  An interesting question comes up if Xen or some
other hypervisor starts vitrtualizing memory.  In such cases, would
it make more sense to allow the hypervisor do all resizing or do
we also need hotplug support in the OS for optimal performance?

-- 
Mike
