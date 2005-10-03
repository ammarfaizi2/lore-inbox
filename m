Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbVJCXgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbVJCXgx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 19:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932695AbVJCXgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 19:36:53 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:36822 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932098AbVJCXgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 19:36:53 -0400
Date: Mon, 3 Oct 2005 16:36:27 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: kurosawa@valinux.co.jp, taka@valinux.co.jp, magnus.damm@gmail.com,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] Re: Ok to change cpuset flags for sched domains?
 (was [PATCH 1/3] CPUMETER ...)
Message-Id: <20051003163627.772fa047.pj@sgi.com>
In-Reply-To: <20051003140032.GA6629@in.ibm.com>
References: <20050908225539.0bc1acf6.pj@sgi.com>
	<20050909.203849.33293224.taka@valinux.co.jp>
	<20050909063131.64dc8155.pj@sgi.com>
	<20050910.161145.74742186.taka@valinux.co.jp>
	<20050910015209.4f581b8a.pj@sgi.com>
	<20050926093432.9975870043@sv1.valinux.co.jp>
	<20050927013751.47cbac8b.pj@sgi.com>
	<20050927113902.C78A570046@sv1.valinux.co.jp>
	<20050927084905.7d77bdde.pj@sgi.com>
	<20051002000159.3f15bf7a.pj@sgi.com>
	<20051003140032.GA6629@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar, responding to pj:
> > I think I goofed in encouraging you to overload "cpu_exclusive"
> > with defining dynamic scheduler domains. 
> 
> I am not entirely convinced ...

You're right.  It's correct the way it is.

The placement of dynamic sched domains does not cause some
user visible change in behaviour that it makes sense for the
user to want to turn on for some cpusets and off for others.

Rather it is a performance optimization for scheduler scalability,
and the resulting domains must cover all the CPUs in the system.

So the placement of sched domains should not be a user option,
and should be done for all cpu_exclusive domains as it is
done now.

Good.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
