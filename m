Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269120AbUINCHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269120AbUINCHi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 22:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269112AbUINCFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 22:05:48 -0400
Received: from holomorphy.com ([207.189.100.168]:56463 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269106AbUINCEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 22:04:33 -0400
Date: Mon, 13 Sep 2004 19:04:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Constantine Gavrilov <constg@qlusters.com>
Cc: Christoph Hellwig <hch@infradead.org>, bugs@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: Calling syscalls from x86-64 kernel results in a crash on Opteron machines
Message-ID: <20040914020417.GH9106@holomorphy.com>
References: <4145A8E1.8010409@qlusters.com> <20040913153803.A27282@infradead.org> <4145B750.6060900@qlusters.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4145B750.6060900@qlusters.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
>> Which you shouldn't do in the first place.

On Mon, Sep 13, 2004 at 06:05:52PM +0300, Constantine Gavrilov wrote:
> Function kernel_thread() on i386 is implemented by putting the args to 
> appropriate regs and calling int 0x80, resulting in a system call 
> clone() on i386.
> I have also found the "syscall" instruction in x86-64 kernel specific 
> code (it does not call _syscall() macros directly, though). So, 
> "shouldn't do" is a bit too strong.
> What I am writing is an application, and not interface. As such, it is 
> not much different from its requierements from a user-space application. 
> If user-space application may call system calls, why a kernel space 
> application cannot?
> And BTW, kernel-space applications have their own place even if the 
> concept seems foreign to you.

This is not something we particularly endorse, but when making syscalls
the function calls sys_foo() suffice. Also, ia32 does not use syscall
traps for kernel_thread() in current 2.6.x


-- wli
