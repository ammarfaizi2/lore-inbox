Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751039AbWD2IQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbWD2IQW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 04:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWD2IQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 04:16:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41605 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751039AbWD2IQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 04:16:21 -0400
Date: Sat, 29 Apr 2006 01:14:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: holzheu@de.ibm.com, schwidefsky@de.ibm.com, penberg@cs.helsinki.fi,
       ioe-lkml@rameria.de, joern@wohnheim.fh-wedel.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: Hypervisor File System
Message-Id: <20060429011423.7db4075a.akpm@osdl.org>
In-Reply-To: <20060429075133.GA1886@kroah.com>
References: <20060428112225.418cadd9.holzheu@de.ibm.com>
	<20060428234441.1407c82f.akpm@osdl.org>
	<20060429075133.GA1886@kroah.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
>  On Fri, Apr 28, 2006 at 11:44:41PM -0700, Andrew Morton wrote:
>  > Michael Holzheu <holzheu@de.ibm.com> wrote:
>  > >
>  > >  As mount point for the filesystem /sys/hypervisor is created.
>  > 
>  > What does this mean, btw?  I don't see code there creating a new sysfs
>  > directory, and userspace cannot do this.
> 
>  The call to subsystem_register() does this.

Ah.  It's using "hypfs".  Michael was tricking us.

>  > Also, "/sys/hypervisor" is probably insufficiently specific.  In a few
>  > years time people will be asking "Which hypervisor?  We have eighteen of them!".
> 
>  I agree, the xen people are already clammering for some kind of sysfs
>  tree and wanted to create /sys/hypervisor/xen.  How about
>  /sys/hypervisor/s390?

Yes, something like that.  Even "hypfs" is possibly too generic.
