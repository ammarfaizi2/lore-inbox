Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262781AbVEHB0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262781AbVEHB0T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 21:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262786AbVEHB0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 21:26:19 -0400
Received: from mx.freeshell.org ([192.94.73.21]:43747 "EHLO sdf.lonestar.org")
	by vger.kernel.org with ESMTP id S262781AbVEHB0P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 21:26:15 -0400
From: Jim Nance <jlnance@sdf.lonestar.org>
Date: Sun, 8 May 2005 01:25:21 +0000
To: Dave Jones <davej@redhat.com>, Willy Tarreau <willy@w.ods.org>,
       Andrew Morton <akpm@osdl.org>, Ricky Beam <jfbeam@bluetronic.net>,
       nico-kernel@schottelius.org, linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo format - arch dependent!
Message-ID: <20050508012521.GA24268@SDF.LONESTAR.ORG>
References: <20050419121530.GB23282@schottelius.org> <Pine.GSO.4.33.0505062324550.1894-100000@sweetums.bluetronic.net> <20050506211455.3d2b3f29.akpm@osdl.org> <20050507075828.GF777@alpha.home.local> <20050507165357.GA19601@redhat.com> <20050507170555.GA19329@alpha.home.local> <20050507172005.GB26088@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050507172005.GB26088@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2005 at 01:20:05PM -0400, Dave Jones wrote:
> On Sat, May 07, 2005 at 07:05:56PM +0200, Willy Tarreau wrote:

>  > system "hey, I'd like this type of workload, how many process should
>  > I start, and where should I bind them ?".
> 
> I think generalising this and having a method to do this in the kernel
> is a much better idea than each application parsing this themselves.
> Things are only getting more and more complex as time goes on,
> and I don't trust application developers to get it right.

As a developer of a multiprocess/multithreaded application I can assure
you that you are right not to trust application developers to get this
right.  The idea that a programmer understands the behavior of the
applications they write is largely a myth.  Furthermore, I suspect
that SMT will evolve in directions that make the idea of a processor
more and more fuzzy.  I don't think it is wise to construct any
interface that suggests knowing the hardware details is good, or that
processes should be bound by userland.  Certainly it is sometimes
necessary for userland to do this, but we should look at that as a
bug in the kernel.

Thanks,

Jim


-- 
jlnance@sdf.lonestar.org
SDF Public Access UNIX System - http://sdf.lonestar.org
