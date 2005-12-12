Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbVLLCbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbVLLCbZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 21:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbVLLCbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 21:31:25 -0500
Received: from ns1.suse.de ([195.135.220.2]:42650 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751036AbVLLCbZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 21:31:25 -0500
Date: Mon, 12 Dec 2005 03:31:14 +0100
From: Andi Kleen <ak@suse.de>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>, Andi Kleen <ak@suse.de>,
       Rohit Seth <rohit.seth@intel.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, zach@vmware.com,
       shai@scalex86.org, nippung@calsoftinc.com
Subject: Re: [discuss] [patch] x86_64:  align and pad x86_64 GDT on page boundary
Message-ID: <20051212023114.GV11190@wotan.suse.de>
References: <20051208215514.GE3776@localhost.localdomain> <1134083357.7131.21.camel@akash.sc.intel.com> <20051208231141.GX11190@wotan.suse.de> <1134084367.7131.32.camel@akash.sc.intel.com> <20051208232610.GY11190@wotan.suse.de> <1134085511.7131.53.camel@akash.sc.intel.com> <20051208234320.GB11190@wotan.suse.de> <20051209221922.GA3676@localhost.localdomain> <Pine.LNX.4.64.0512111829560.3641@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512111829560.3641@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2005 at 06:34:16PM -0800, Zwane Mwaikambo wrote:
> On Fri, 9 Dec 2005, Ravikiran G Thirumalai wrote:
> 
> > > For the BP case it's ok as 
> > > long as the beginning is correctly aligned and the rest 
> > > is read-only.
> > 
> > Just that any writes on the bp GDT will invalidate the idt_table cacheline,
> > which is read mostly (as Nippun pointed out).  So could we keep the padding
> > as it is for the BP too? 
> 
> But how often is this occuring? I presume this is for the virtualisation 

GDT writes happen often if you use threads with TLS.

> case only?

In this case for programs running on ScaleX86's hypervisor yes.

-Andi
