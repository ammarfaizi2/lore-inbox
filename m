Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVCHRTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVCHRTm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 12:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbVCHRTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 12:19:42 -0500
Received: from peabody.ximian.com ([130.57.169.10]:36763 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261404AbVCHRTg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 12:19:36 -0500
Subject: Re: Question regarding thread_struct
From: Robert Love <rml@novell.com>
To: Imanpreet Arora <imanpreet@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <c26b959205030809044364b923@mail.gmail.com>
References: <c26b959205030809044364b923@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 08 Mar 2005 12:13:20 -0500
Message-Id: <1110302000.23923.14.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-08 at 22:34 +0530, Imanpreet Arora wrote:

> 	I am wondering if someone could provide information as to how
> thread_struct is kept in memory. Robert Love mentions that it is kept
> at the "lowest"  kernel address in case of x86 based platform. Could
> anyone answer these questions.

Kernel _stack_ address for the given process.

> a)	When a stack is resized, is the thread_struct structure copied onto
> a new place?

This is the kernel stack, not any potential user-space stack.  Kernel
stacks are not resized.

> b)	What is the advantage of this scheme as against a fixed "virtual-address"?

This is inside of the kernel, not in user-space.

> c)	Also could you kindly point the relevant files which do all this
> stuff "shed.c"(?)

See kernel/fork.c and alloc_thread_info() and friends in
<asm/thread_info.h>.

	Robert Love


