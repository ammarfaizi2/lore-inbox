Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262299AbVBXMTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbVBXMTE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 07:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbVBXMTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 07:19:03 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:40077 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262299AbVBXMQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 07:16:31 -0500
Date: Thu, 24 Feb 2005 17:46:49 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Vivek Goyal <vgoyal@in.ibm.com>, haveblue@us.ibm.com,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       ebiederm@xmission.com
Subject: Re: [Fastboot] Re: [PATCH] Fix for broken kexec on panic
Message-ID: <20050224121649.GB5781@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <1109236432.5148.192.camel@terminator.in.ibm.com> <20050224011312.29668947.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050224011312.29668947.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 01:13:12AM -0800, Andrew Morton wrote:
> Vivek Goyal <vgoyal@in.ibm.com> wrote:
> >
> > Kexec on panic is broken on i386 in 2.6.11-rc3-mm2 because of
> >  re-organization of boot memory allocator initialization code.
> 
> OK...
> 
> Where are we up to with these patches, btw?  Do you consider them
> close-to-complete?  Do you have a feel for what proportion of machines will
> work correctly?

After the rework of kexec patches, there is very minimal kernel code needed
for kdump and most of the code is in user space kexec-tools. The changes
needed in kexec-tools to load the crashdump kernel and generate ELF headers,
for x86 architecture are done and will be posted for comments today by Vivek. 

Currently the work remaining is to capture the old-kernel memory during second 
kernel boot up. There is some lack of consensus whether this functionality 
should go in kernel-space (/proc/vmcore) or user-space (a separate utility
which can be run from initrd). Before the last kexec rework, kdump has the 
facility to do /proc/vmcore and now it has to be re-done accordingly. There is 
some code already done by Eric to do it in user-space. We are evaluating both
the approaches and should arrive at the conclusion asap.

Thanks
Maneesh

-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044990
