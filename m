Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVAKSDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVAKSDe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 13:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbVAKSCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 13:02:51 -0500
Received: from colin2.muc.de ([193.149.48.15]:2573 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261208AbVAKRue (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 12:50:34 -0500
Date: 11 Jan 2005 18:50:28 +0100
Date: Tue, 11 Jan 2005 18:50:28 +0100
From: Andi Kleen <ak@muc.de>
To: Yinghai Lu <yhlu@tyan.com>
Cc: "'Siddha, Suresh B'" <suresh.b.siddha@intel.com>,
       "'Mikael Pettersson'" <mikpe@csd.uu.se>, jamesclv@us.ibm.com,
       Matt_Domsch@dell.com, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: 256 apic id for amd64
Message-ID: <20050111175028.GB17077@muc.de>
References: <20050110200425.B30630@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 09:44:07AM -0800, Yinghai Lu wrote:
> Actually It seems the Opteron System with Nvidia chip set can lift the bsp
> (core0/node0) to 0x10, and the jiffies is still changing in for CPU0. I try
> to enable the 8259 PIC in SB, it will cause the jiffies not changing.
> At the same time in the AMD 8111 SB MB, the 8259 PIC is default enabled, So
> after I lift the APIC id, it will stop jiffies. The problem is after I
> disable the 8259 in amd8111, it will cause other booting problem. maybe the
> io-apic is not enabled properly.

There is code that assumes all legacy interrupts (that includes the timer)
are routed to IO-APIC #0.  I still didn't get quite why you want to 
change that anyways. 

-Andi
