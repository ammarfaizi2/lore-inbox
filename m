Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbTDSFNm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 01:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263357AbTDSFNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 01:13:41 -0400
Received: from dp.samba.org ([66.70.73.150]:48335 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263355AbTDSFNk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 01:13:40 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, sfr@canb.auug.org.au,
       Andries.Brouwer@cwi.nl, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] struct loop_info64 
In-reply-to: Your message of "Fri, 18 Apr 2003 11:06:30 MST."
             <20030418180630.GA7247@kroah.com> 
Date: Sat, 19 Apr 2003 14:54:59 +1000
Message-Id: <20030419052538.9EA962C0C7@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030418180630.GA7247@kroah.com> you write:
> On Fri, Apr 18, 2003 at 10:55:21AM -0700, Linus Torvalds wrote:
> > 
> > But we really should have a __ptr64 type too. There's just no sane way to
> > tell gcc about it without requireing casts, which is inconvenient (which
> > means that right now it you just have to use __u64 for pointers if you
> > want to be able to share the structure across 32/64-bit architectures).
> 
> I think that's what Stephan and Rusty tried to do with the
> kernel_ulong_t typedef in include/linux/mod_devicetable.h.
> 
> Maybe that typedef could be changed into the __ptr64 type?  Stephan?

Stephen is away on holidays.

The kernel_ulong_t here is different.  It's because (for good or bad)
that header contains longs and is shared with userspace.  Fortunately,
it's only now shared with one very particular program, which is in the
kernel source tree, so kludgery is less harmful.

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
