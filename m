Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbTJPT4D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 15:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263136AbTJPT4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 15:56:03 -0400
Received: from gaia.cela.pl ([213.134.162.11]:46600 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S263129AbTJPTz7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 15:55:59 -0400
Date: Thu, 16 Oct 2003 21:55:05 +0200 (CEST)
From: Maciej Zenczykowski <maze@cela.pl>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Sanil K <Sanil.K@lntinfotech.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Interrupt handling
In-Reply-To: <Pine.LNX.4.53.0310160934410.590@chaos>
Message-ID: <Pine.LNX.4.44.0310162152590.29425-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Oct 2003, Richard B. Johnson wrote:

> The memory-map idea has security problems, though.
> If the area ever gets unmapped (the user exits), a
> fatal error could occur in kernel mode within the
> ISR. In general, it's always best to allocate an
> interrupt-safe buffer within the driver (module),
> that is guaranteed to persist as long as the driver
> is installed. This ultimately means that a copy
> operation is necessary.
> 
> Memory-to-memory copy is real fast now days. The
> copy_to_user() is just memcpy() with a trap mechanism
> that can save the kernel from a user-induced seg-fault.
> The actual trap is hardware-induced in ix86 machines
> and therefore adds no overhead to the normal copy operation.

Is there any reason why we couldn't via kernel routine let user space 
access read-only certain pages of kernel memory?  I.e. having the 
userspace function call the driver to map into it's (user) address space a 
read-only mapping of the drivers (kernel) private r/w area?
If I'm not mistaken this is doable on x86 hardware isn't it?

Cheers,
MaZe.

