Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263468AbTKWVi3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 16:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbTKWVi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 16:38:29 -0500
Received: from holomorphy.com ([199.26.172.102]:27063 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263468AbTKWVi2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 16:38:28 -0500
Date: Sun, 23 Nov 2003 13:38:17 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andi Kleen <ak@colin2.muc.de>,
       Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@muc.de>,
       Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       jbarnes@sgi.com, efocht@hpce.nec.com, John Hawkes <hawkes@sgi.com>,
       wookie@osdl.org
Subject: Re: [RFC] generalise scheduling classes
Message-ID: <20031123213817.GU22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Piggin <piggin@cyberone.com.au>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andi Kleen <ak@colin2.muc.de>, Ingo Molnar <mingo@elte.hu>,
	Andi Kleen <ak@muc.de>, Con Kolivas <kernel@kolivas.org>,
	Andrew Morton <akpm@osdl.org>, jbarnes@sgi.com, efocht@hpce.nec.com,
	John Hawkes <hawkes@sgi.com>, wookie@osdl.org
References: <Pine.LNX.4.56.0311171638140.29083@earth> <20031118173607.GA88556@colin2.muc.de> <Pine.LNX.4.56.0311181846360.23128@earth> <20031118235710.GA10075@colin2.muc.de> <3FBAF84B.3050203@cyberone.com.au> <501330000.1069443756@flay> <3FBF099F.8070403@cyberone.com.au> <1010800000.1069532100@[10.10.2.4]> <3FC01817.3090705@cyberone.com.au> <3FC0A0C2.90800@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FC0A0C2.90800@cyberone.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 23, 2003 at 10:57:54PM +1100, Nick Piggin wrote:
> Class is struct sched_class in include/linux/sched.h
> Default classes are built by arch_init_sched_classes in kernel/sched.c
> http://www.kerneltrap.org/~npiggin/w23/
> The patch in question is this one
> http://www.kerneltrap.org/~npiggin/w23/broken-out/sched-domain.patch

There's a small terminological oddity in that "class" is usually meant
to describe policies governing a task, and "domain" system partitions
like the bits in your patch (I don't recall if they're meant to be
logical or physical). e.g. usage elsewhere would say that there is an
"interactive class", a "timesharing class", a "realtime class", and so
on. Apart from that (and I suppose it's a minor concern), this appears
relatively innocuous.


-- wli
