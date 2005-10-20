Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751783AbVJTH1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbVJTH1Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 03:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbVJTH1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 03:27:24 -0400
Received: from ns2.suse.de ([195.135.220.15]:415 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751783AbVJTH1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 03:27:24 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: x86_64: 2.6.14-rc4 swiotlb broken
Date: Thu, 20 Oct 2005 09:27:48 +0200
User-Agent: KMail/1.8
Cc: Jon Mason <jdmason@us.ibm.com>, Muli Ben-Yehuda <mulix@mulix.org>,
       Ravikiran G Thirumalai <kiran@scalex86.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, shai@scalex86.org,
       clameter@engr.sgi.com, muli@il.ibm.com
References: <20051017093654.GA7652@localhost.localdomain> <20051017184523.GB26239@granada.merseine.nu> <20051019171805.GF10863@us.ibm.com>
In-Reply-To: <20051019171805.GF10863@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510200927.48989.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 October 2005 19:18, Jon Mason wrote:
> I have run a few tests on the original code and the patches posted to the
> list, and have some interesting results.  First, my system setup:  Dual
> Opteron, 8GB RAM, SIL SATA controller (which is apparently 32bit), pcnet32
> NIC (compiled as a module) connected to the network.  The latter 2 should
> show any bounce buffer problems.

We don't care about AMD systems for this problem because they
don't use swiotlb in normal operations, but the AGP remapping hardware (except 
on one particulr chipset, but people don't build servers from that) 

If anything then testing results from Summit3 based Intel x86 NUMA systems 
would be interesting.

-Andi
 
