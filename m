Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263429AbUFFMO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbUFFMO0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 08:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263380AbUFFMOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 08:14:24 -0400
Received: from holomorphy.com ([207.189.100.168]:38833 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263429AbUFFMNl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 08:13:41 -0400
Date: Sun, 6 Jun 2004 05:13:27 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, mikpe@csd.uu.se,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based implementation
Message-ID: <20040606121327.GT21007@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, Rusty Russell <rusty@rustcorp.com.au>,
	mikpe@csd.uu.se, linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20040604095929.GX21007@holomorphy.com> <16576.23059.490262.610771@alkaid.it.uu.se> <20040604112744.GZ21007@holomorphy.com> <20040604113252.GA21007@holomorphy.com> <20040604092316.3ab91e36.pj@sgi.com> <20040604162853.GB21007@holomorphy.com> <20040604104756.472fd542.pj@sgi.com> <20040604181233.GF21007@holomorphy.com> <1086487651.11454.19.camel@bach> <20040606051657.3c9b44d3.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040606051657.3c9b44d3.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty wrote:
>> Yes, NR_CPUS needs to get to userspace somehow sanely if we want to fix
>> this in general.

On Sun, Jun 06, 2004 at 05:16:57AM -0700, Paul Jackson wrote:
> Are you saying that NR_CPUS is needed, or just the number of longs in a
> cpumask (sizeof (cpumask_t), essentially)?
> I can see where the size is needed, in order to make the system calls to
> set and get masks of arbitrary size.  Since these sizes are a multiple
> of sizeof(long), at a minimum this means user code needs to know the
> number of longs in a mask.  Though the number of bytes, as in
> sizeof(cpumask_t), rather than of longs, is perhaps a less surprising
> interface.
> I can't see where the user code cares whether NR_CPUS is 47 or 48?
> Am I missing something?
> I am a firm believer in passing the minimum essential information across
> major boundaries.  Passing too much creates maintaince problems, and
> encourages misuse of information, resulting in bogus user code.

You've been told, and several times already. The current example is
userspace needing to know when to stop trying to online cpus.

-- wli
