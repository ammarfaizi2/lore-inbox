Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbUEFNX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbUEFNX0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 09:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbUEFNVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 09:21:34 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:44929 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S262176AbUEFNUR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 09:20:17 -0400
From: "Sourav Sen" <souravs@india.hp.com>
To: "'Matt Domsch'" <Matt_Domsch@dell.com>,
       "'Sourav Sen'" <souravs@india.hp.com>
Cc: <matthew.e.tolentino@intel.com>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>
Subject: RE: [2.6.6 PATCH] Exposing EFI memory map
Date: Thu, 6 May 2004 18:50:07 +0530
Message-ID: <004801c4336c$daae5840$39624c0f@india.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
In-Reply-To: <20040506124649.GA13482@lists.us.dell.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

+ -----Original Message-----
+ From: Matt Domsch [mailto:Matt_Domsch@dell.com]
+ On Thu, May 06, 2004 at 02:22:46PM +0530, Sourav Sen wrote:
+ > The following simple patch creates a read-only file
+ > "memmap" under <mount point>/firmware/efi/ in sysfs
+ > and exposes the efi memory map thru it.
+ 
+ I'm not generally opposed, but have a couple questions.
+ 
+ 1) Why does userspace / humans need to know this?  For 
+ debugging firmware?
	
	Maybe. But the point I had in mind is, say for example
memory diagnostics applications/exercisers which reads (Blind
reads, without caring about contents) memory
to uncover errors (single bit errors)  can use
this to know the usable ranges and map them thru /dev/mem and
read those ranges.

+ 
+ 2) Can the memory map output ever be larger than PAGE_SIZE (lower
+ limit is 4KB on x86)?  If not, what guarantees that?  If so, you need
+ your own read mechanism rather than the generic sysfs one.
+ 

	I don't have an answer right now. I'll investigate. Tony Luck also 
expressed similar concerns and suggested seq*() interfaces. I'll see
how I can do that.

+ The one-value-per-file rule has an exception for an array of values of
+ the same type per Documentation/filesystems/sysfs.txt, which this
+ looks to adhere to.
+ 
+ Thanks,
+ Matt
+ 
+ -- 
+ Matt Domsch
+ Sr. Software Engineer, Lead Engineer
+ Dell Linux Solutions linux.dell.com & www.dell.com/linux
+ Linux on Dell mailing lists @ http://lists.us.dell.com
+ 

Thanks
Sourav
