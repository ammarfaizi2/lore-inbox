Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbVJ2EZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbVJ2EZv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 00:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbVJ2EZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 00:25:51 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:61899 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751128AbVJ2EZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 00:25:50 -0400
Date: Fri, 28 Oct 2005 21:25:36 -0700
From: Paul Jackson <pj@sgi.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched hardcode non-smp set_cpus_allowed
Message-Id: <20051028212536.24258523.pj@sgi.com>
In-Reply-To: <1130549617.7615.50.camel@localhost.localdomain>
References: <20051027085346.27658.76262.sendpatchset@sam.engr.sgi.com>
	<1130549617.7615.50.camel@localhost.localdomain>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty wrote:
> Hmm, I do slightly prefer the former, since it is exactly the same as
> the SMP case,

I tend to agree with that, in theory.

But the cpu_online_map reference had broken some (driver, module, ...?)
that had wasted a bit of Andrew's time, which was worth something to me
as well.  I was more than happy to make a one-line change if it removed
a small pothole on Andrew's road.

We've got a couple of schools of thought here ... at least.

I tend to prefer having the source code express the general case, and
then using header file magic to optimize the generated code for the uni-
processor systems.  I guess this would be Rusty-style source code,
Andrew-style machine code, and esoteric style headers.

> With our include web, however, that might be tricky.

Yeah.  Not worth messing with, in my book.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
