Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751866AbWCVAYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbWCVAYY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 19:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751867AbWCVAYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 19:24:24 -0500
Received: from xenotime.net ([66.160.160.81]:50570 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751866AbWCVAYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 19:24:23 -0500
Date: Tue, 21 Mar 2006 16:26:30 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, clemens@ladisch.de
Subject: Re: [PATCH] hpet header sanitization
Message-Id: <20060321162630.d995c63c.rdunlap@xenotime.net>
In-Reply-To: <20060321161303.53c2895f.akpm@osdl.org>
References: <20060321144607.153d1943.rdunlap@xenotime.net>
	<20060321161303.53c2895f.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2006 16:13:03 -0800 Andrew Morton wrote:

> "Randy.Dunlap" <rdunlap@xenotime.net> wrote:
> >
> > From: Randy Dunlap <rdunlap@xenotime.net>
> > 
> > Add __KERNEL__ block.
> > Use __KERNEL__ to allow ioctl interface to be usable.
> 
> hm, why?

because there is a test/example source file in (inside)
Documentation/hpet.txt that won't build otherwise.
And because hpet.h contains _userspace_ ioctl interface struct
and macros...


> My general approach to __KERNEL__ fixes is to not support new includers of
> kernel headers but to accept patches which fix up existing applications of
> __KERNEL__.
> 
> It's basically a compromise between the
> dont-include-kernel-headers-from-userspace fundamentalists and the
> but-i-want-my-stuff-to-work pragmatists ;)
> 
> But hpet.h never had __KERNEL__, so there's no regression here.
> 
> That being said, it looks like a sensible change - let's see if we can
> sneak it in without the fundies noticing.

---
~Randy
