Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263302AbVCKNuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263302AbVCKNuq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 08:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263310AbVCKNuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 08:50:46 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:49036 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S263302AbVCKNul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 08:50:41 -0500
Date: Fri, 11 Mar 2005 07:50:32 -0600
From: Michael Raymond <mraymond@sgi.com>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: User mode drivers: part 1, interrupt handling (patch for 2.6.11)
Message-ID: <20050311075029.A92696@goliath.americas.sgi.com>
References: <16945.4650.250558.707666@berry.gelato.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <16945.4650.250558.707666@berry.gelato.unsw.EDU.AU>; from peterc@gelato.unsw.edu.au on Fri, Mar 11, 2005 at 02:36:10PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    I have many users asking for something like this.  Peter's approach is
simple and it appears to solve the problem for many situations.
    With that in mind though, for a more complicated but higher performing
approach please take a look at the User Level Interrupt (ULI) project at
http://oss.sgi.com/projects/uli/.  It requires some per-arch assembly but
with some recent changes we're seeing ~1.5us latency from hardware event to
user space function start.  I'm hoping to add an IA32 port out soon.
     	   	    	    	       	      Thanks,
     	   	    	    	       	      	      Michael

On Fri, Mar 11, 2005 at 02:36:10PM +1100, Peter Chubb wrote:
> 
> As many of you will be aware, we've been working on infrastructure for
> user-mode PCI and other drivers.  The first step is to be able to
> handle interrupts from user space. Subsequent patches add
> infrastructure for setting up DMA for PCI devices.

-- 
Michael A. Raymond              Office: (651) 683-3434
Core OS Group                   Real-Time System Software
