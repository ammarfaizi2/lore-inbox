Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263237AbTJKFfP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 01:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263238AbTJKFfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 01:35:15 -0400
Received: from waste.org ([209.173.204.2]:12756 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263237AbTJKFfH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 01:35:07 -0400
Date: Sat, 11 Oct 2003 00:35:00 -0500
From: Matt Mackall <mpm@selenic.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, kbugs@pelvoux.nildram.co.uk
Subject: Re: [Bug 1339] New: sleeping function called from invalid	context
Message-ID: <20031011053500.GP5725@waste.org>
References: <200010000.1065798616@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200010000.1065798616@[10.10.2.4]>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 08:10:16AM -0700, Martin J. Bligh wrote:
>            Summary: sleeping function called from invalid context
>     Kernel Version: 2.6.0-test6
>             Status: NEW
>           Severity: normal
>              Owner: akpm@digeo.com
>          Submitter: kbugs@pelvoux.nildram.co.uk
> 
> 
> Distribution: Debian Sarge
> 
> Hardware Environment:
> 
> Gateway PC, Intel Pentium III (Katmai) 450Mhz, Intel 440BX Chipset, 640Mb RAM
> 
> Software Environment:
> 
> Gnu C                  3.3.2
> Gnu make               3.80
> util-linux             2.12
> mount                  2.12
> e2fsprogs              1.35-WIP
> nfs-utils              1.0.5
> Linux C Library        2.3.2
> Dynamic linker (ldd)   2.3.2
> Procps                 3.1.12
> Net-tools              1.60
> Console-tools          0.2.3
> Sh-utils               5.0
> Modules Loaded         nfsd exportfs lockd sunrpc reiserfs 8250 serial_core
> eepro100 mii rtc
> 
> Problem Description:
> 
> The following message appeared on the system log:
> 
> Debug: sleeping function called from invalid context at include/asm/uaccess.h:473
> in_atomic():0, irqs_disabled():1
> Call Trace:
>  [<c011bd58>] __might_sleep+0x88/0x90
>  [<c010c55f>] save_v86_state+0x6f/0x1f0
>  [<c010d017>] handle_vm86_fault+0xb7/0xa10
>  [<c0141e21>] do_no_page+0x191/0x2f0
>  [<c0140fc6>] zeromap_pte_range+0x36/0x70
>  [<c010b070>] do_general_protection+0x0/0xa0
>  [<c010a399>] error_code+0x2d/0x38
>  [<c010a1ef>] syscall_call+0x7/0xb
> 
> Steps to reproduce:
> 
> I don't have a method to reproduce - this just appeared in the log.
> 

I have a fix for this in the works.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
