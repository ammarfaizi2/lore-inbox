Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932709AbVLHXUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932709AbVLHXUZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 18:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932710AbVLHXUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 18:20:25 -0500
Received: from fmr21.intel.com ([143.183.121.13]:41399 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S932709AbVLHXUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 18:20:23 -0500
Subject: Re: [discuss] [patch] x86_64:  align and pad x86_64 GDT on page
	boundary
From: Rohit Seth <rohit.seth@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, zach@vmware.com,
       shai@scalex86.org, nippung@calsoftinc.com
In-Reply-To: <20051208231141.GX11190@wotan.suse.de>
References: <20051208215514.GE3776@localhost.localdomain>
	 <1134083357.7131.21.camel@akash.sc.intel.com>
	 <20051208231141.GX11190@wotan.suse.de>
Content-Type: text/plain
Organization: Intel 
Date: Thu, 08 Dec 2005 15:26:07 -0800
Message-Id: <1134084367.7131.32.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Dec 2005 23:19:13.0583 (UTC) FILETIME=[CD3B63F0:01C5FC4D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-09 at 00:11 +0100, Andi Kleen wrote:
> On Thu, Dec 08, 2005 at 03:09:17PM -0800, Rohit Seth wrote:
> >
> > IIRC, Zach's patches for gdt alignment, moved the gdts from per_cpu data
> > structure to each secondary CPU dynamically allocating page for its gdt.
> 
> Kiran's patch does this too.  Except for the BP GDT, which could
> be shared with the single IDT.
> 

...that padding in BP's GDT (in this and original patches) could be
because of the Xen requirements to have dedicated pages for gdt.

-rohit




