Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262638AbUBZDL3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 22:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbUBZDL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 22:11:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:22702 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262638AbUBZDLQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 22:11:16 -0500
Date: Wed, 25 Feb 2004 19:11:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: bgerst@didntduck.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Clean up sys_ioperm stubs
Message-Id: <20040225191140.36288919.akpm@osdl.org>
In-Reply-To: <20040226030523.GE31035@parcelfarce.linux.theplanet.co.uk>
References: <403D5F32.4080805@quark.didntduck.org>
	<20040226030523.GE31035@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
>
> On Wed, Feb 25, 2004 at 09:51:30PM -0500, Brian Gerst wrote:
> > Remove stubs for sys_ioperm for non-x86 arches, using sys_ni_syscall 
> > instead where applicable.
> 
> I have better suggestion: make sys_ioperm() a cond_syscall().  Then kill
> its implementation on all platforms where it just returns -ENOSYS.

Why is that better?  Sticking a pointer to the not-implemented-syscall into
the syscall table is pretty darn explicit.

