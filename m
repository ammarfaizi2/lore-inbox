Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbVHIEa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbVHIEa0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 00:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbVHIEa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 00:30:26 -0400
Received: from ozlabs.org ([203.10.76.45]:50620 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932444AbVHIEaZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 00:30:25 -0400
Subject: Re: Compiling module-init-tools versions after v3.0
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Haninger <ahaning@gmail.com>
Cc: Adrian Bunk <bunk@stusta.de>, "Adam J. Richter" <adam@yggdrasil.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <105c793f0508081812353a07d3@mail.gmail.com>
References: <105c793f050808150810784ef3@mail.gmail.com>
	 <20050808223209.GL4006@stusta.de>
	 <105c793f0508081812353a07d3@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 09 Aug 2005 14:30:22 +1000
Message-Id: <1123561822.13481.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-08 at 21:12 -0400, Andrew Haninger wrote:
> On 8/8/05, Adrian Bunk <bunk@stusta.de> wrote:
> > But this could be better handled in module-init-tools.
> Here's hoping it will be once 3.2 is released.
> 
> Thanks again.
> 
> -Andy

Thanks for this report!  This is the first I've heard of it (Adam CC'd
me, thanks!).

Turns out the "docbook2man" uses the *last* <refentrytitle> as the
output filename, so it was building "modprobe.d.5" instead of
"modprobe.conf.5".  As a result, modprobe.conf.5 was always old, even in
the tarball I uploaded for 3.1 (when the second refentrytitle went into
the man page), and every "make" tried to rebuild it.

Release coming,
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

