Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264683AbUEXUaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264683AbUEXUaV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 16:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264686AbUEXUaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 16:30:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:31915 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264683AbUEXU3L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 16:29:11 -0400
Date: Mon, 24 May 2004 13:29:10 -0700
From: Chris Wright <chrisw@osdl.org>
To: shanthi kiran pendyala <skiranp@cisco.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mmap problem (VM_DENYWRITE)
Message-ID: <20040524132910.K22989@build.pdx.osdl.net>
References: <20040519062044.15651.qmail@web90107.mail.scd.yahoo.com> <000a01c441bf$ccb83600$322147ab@amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000a01c441bf$ccb83600$322147ab@amer.cisco.com>; from skiranp@cisco.com on Mon, May 24, 2004 at 11:49:10AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* shanthi kiran pendyala (skiranp@cisco.com) wrote:
> The complete prot flag is (VM_READ | VM_WRITE | VM_EXEC | VM_GROWSUP |
> VM_DENYWRITE)
[snip]
> Output after running test program
> =================================
>  building page tables for va 0x2aac5000 phy 0x10940000 
>  vsize 0x20000 psize 0x20000 prot 0xa07
> 
[snip]

>     printk("<1> vsize 0x%lx psize 0x%lx prot 0x%lx\n",
>            vsize, psize, vma->vm_page_prot.pgprot);

I believe you've drawn the wrong conclusion.  This contains page
protection bits relevant for the page tables.  You've decoded
vm_page_prot as if it were vm_flags.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
