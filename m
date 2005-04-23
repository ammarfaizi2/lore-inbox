Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVDWDaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVDWDaN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 23:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbVDWDaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 23:30:13 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:7365 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261413AbVDWDaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 23:30:07 -0400
Message-ID: <1114227003.4269c13be5f8b@imap.linux.ibm.com>
Date: Fri, 22 Apr 2005 23:30:03 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Nagesh Sharyathi <sharyathi@in.ibm.com>, akpm@osdl.org,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       maneesh@in.ibm.com
Subject: Re: [Fastboot] Re: Kdump Testing
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.7
X-Originating-IP: 9.182.63.135
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting "Eric W. Biederman" <ebiederm@xmission.com>:

> Nagesh Sharyathi <sharyathi@in.ibm.com> writes:
> 
> > Here is the console boot log, before the machine jumps to BIOS 
> > after hang during panic kerenl boot
> 
> Ok thanks.  So this is manually triggered with SysRq
> and the kexec part works but the recover kernel simply fails
> to boot.
> 
> It looks like that hunk of the ACPI code that messes up maxcpus=1
> needs to be looked at.

I faced the similiar issue on one of my machine. Little debugging showed that
Boot cpu sends an INIT IPI to application processor to wake it up and then boot
cpu loses its way and jumps to bios. Strange....

Further, in my case this problem was noticed only if crash happened on non-boot
cpu.

It works well with Uniporcessor capture kernel. For the time being sufficient 
to capture the dump but it is always good idea to be able to boot and SMP kernel
as well.


Thanks
Vivek
