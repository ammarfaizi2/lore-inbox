Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262617AbUBZDF2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 22:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262615AbUBZDF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 22:05:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14290 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262617AbUBZDFZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 22:05:25 -0500
Date: Thu, 26 Feb 2004 03:05:23 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Brian Gerst <bgerst@didntduck.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Clean up sys_ioperm stubs
Message-ID: <20040226030523.GE31035@parcelfarce.linux.theplanet.co.uk>
References: <403D5F32.4080805@quark.didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403D5F32.4080805@quark.didntduck.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 09:51:30PM -0500, Brian Gerst wrote:
> Remove stubs for sys_ioperm for non-x86 arches, using sys_ni_syscall 
> instead where applicable.

I have better suggestion: make sys_ioperm() a cond_syscall().  Then kill
its implementation on all platforms where it just returns -ENOSYS.
