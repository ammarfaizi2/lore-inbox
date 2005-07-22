Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbVGVLhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbVGVLhu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 07:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbVGVLht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 07:37:49 -0400
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:56575 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262079AbVGVLhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 07:37:47 -0400
Date: Fri, 22 Jul 2005 13:37:46 +0200
From: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 10 GB in Opteron machine
Message-Id: <20050722133746.67e5f5d3.Christoph.Pleger@uni-dortmund.de>
In-Reply-To: <20050722103955.GI30510@unthought.net>
References: <20050722105516.6ccffb8f.Christoph.Pleger@uni-dortmund.de>
	<42E0B6E4.1030303@pobox.com>
	<20050722113138.5d81c770.Christoph.Pleger@uni-dortmund.de>
	<20050722103955.GI30510@unthought.net>
Organization: Universitaet Dortmund
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-sun-solaris2.7)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, 22 Jul 2005 12:39:55 +0200
Jakob Oestergaard <jakob@unthought.net> wrote:

> > 1. Is it possible to compile a 64-bit kernel on a 32-bit machine (or
> > at least on a 64-bit machine with 32-bit software) and if yes, how
> > can I do that?
> 
> Yes. On Debian Sarge, I have a few wrapper scripts to accomplish it -
> all attached to this mail - just untar them in /usr/local/bin on a
> standard x86 32-bit Sarge distro.  Use 'kmake' instead of 'make' when
> you are working with your kernel source (eg. 'kmake menuconfig',
> 'kmake all')
> 
> Sarge comes with all the necessary toolchain support to build a 64-bit
> kernel.
> 
> It should be equally possible on most other distros of course, I just
> haven't felt the urge to go waste my time with them :)

I am also using Debian sarge. I extracted the tarfile to /usr/local/bin
end executed "kmake menuconfig". Everything seemed fine so far. But a
few seconds after starting the compilation (kmake bzImage) I got this
error message:

In file included from <snip>
...
<snip>
include/asm/mpspec.h:6:25: mach_mpspec.h: No such file or directory



Hm. I understand why that file cannot be found: It only exists in the
asm-i386 directory. But why does the compilation process look for a file
that belongs to i386, but not to x86_64?

Christoph  
