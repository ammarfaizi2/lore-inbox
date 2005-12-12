Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbVLLC2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbVLLC2v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 21:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbVLLC2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 21:28:51 -0500
Received: from fsmlabs.com ([168.103.115.128]:55002 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1751033AbVLLC2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 21:28:50 -0500
X-ASG-Debug-ID: 1134354525-4076-59-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Sun, 11 Dec 2005 18:34:16 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
cc: Andi Kleen <ak@suse.de>, Rohit Seth <rohit.seth@intel.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, zach@vmware.com, shai@scalex86.org,
       nippung@calsoftinc.com
X-ASG-Orig-Subj: Re: [discuss] [patch] x86_64:  align and pad x86_64 GDT on page
 boundary
Subject: Re: [discuss] [patch] x86_64:  align and pad x86_64 GDT on page
 boundary
In-Reply-To: <20051209221922.GA3676@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0512111829560.3641@montezuma.fsmlabs.com>
References: <20051208215514.GE3776@localhost.localdomain>
 <1134083357.7131.21.camel@akash.sc.intel.com> <20051208231141.GX11190@wotan.suse.de>
 <1134084367.7131.32.camel@akash.sc.intel.com> <20051208232610.GY11190@wotan.suse.de>
 <1134085511.7131.53.camel@akash.sc.intel.com> <20051208234320.GB11190@wotan.suse.de>
 <20051209221922.GA3676@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.6203
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Dec 2005, Ravikiran G Thirumalai wrote:

> > For the BP case it's ok as 
> > long as the beginning is correctly aligned and the rest 
> > is read-only.
> 
> Just that any writes on the bp GDT will invalidate the idt_table cacheline,
> which is read mostly (as Nippun pointed out).  So could we keep the padding
> as it is for the BP too? 

But how often is this occuring? I presume this is for the virtualisation 
case only?

Thanks
