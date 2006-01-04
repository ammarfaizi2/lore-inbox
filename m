Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932495AbWADJTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbWADJTL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 04:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbWADJTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 04:19:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46279 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932495AbWADJTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 04:19:09 -0500
Date: Wed, 4 Jan 2006 01:18:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: dax@gurulabs.com, erich@areca.com.tw, arjan@infradead.org,
       oliver@neukum.org, rlrevell@joe-job.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: ETA for Areca RAID driver (arcmsr) in mainline?
Message-Id: <20060104011841.036ea510.akpm@osdl.org>
In-Reply-To: <20051230113227.2b787d43.rdunlap@xenotime.net>
References: <1135228831.4122.15.camel@mentorng.gurulabs.com>
	<1135229681.439.23.camel@mindpipe>
	<200512220917.41494.oliver@neukum.org>
	<1135239601.2940.5.camel@laptopd505.fenrus.org>
	<20051222052443.57ffe6f9.akpm@osdl.org>
	<1135279895.19320.24.camel@mentorng.gurulabs.com>
	<20051230113227.2b787d43.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rdunlap@xenotime.net> wrote:
>
> Here's a start on some cleanups and a list of general issues.
>  I'm not addressing SCSI or MM/DMA API issues, if there are any.
> 
>  0.  some Kconfig and Makefile cleanups
>  1.  fix arcmsr_device_id_table[] inits;
>  2.  fix return (value); -- don't use parenethese
>  3.  fix one-line-ifs-with-braces -- remove braces
>  4.  struct _XYZ & typedef XYZ, PXYZ -- convert to struct XYZ only
>  5.  check NULL usage
>  6.  no "return;" at end of func; -- removed
>  7.  return -ENXIO instead of ENXIO;
> 
>  Patch for above items is below.
> 
>  More issues, not yet patched:
> 
>  8.  check sparse warnings, stack usage, init/exit sections;
>  9.  don't use // comments;
>  10. use printk levels
>  11. pPCI_DEV: bad naming (throughout driver; don't use mixed case)
>  12. some comments are unreadable (non-ASCII ?)
>  13. uintNN_t int types:  use kernel types except for userspace interfaces
>  14. use kernel-doc
>  15. try to fit source files into 80 columns

Unfortunately I've gone and applied a huge driver update from Erich, so
none of this applies any more.

A recut would be appreciated.  Please include your additional suggestions:

16. Tab size in Linux kernel is 8 (not less).
17. Don't put changelog comments in source files.  That's what
     SCMs are for (source code manager tools).
18. Put arcmsr.txt in Documentation/scsi/, not in scsi/arcmsr/.
19. Maybe use sysfs (/sys) instead of /proc.

In the updated changelog, thanks.
