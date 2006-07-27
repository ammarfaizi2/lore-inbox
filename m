Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161040AbWG0EB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161040AbWG0EB2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 00:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWG0EB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 00:01:28 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:29629 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751222AbWG0EB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 00:01:27 -0400
Date: Wed, 26 Jul 2006 21:00:20 -0700
From: Paul Jackson <pj@sgi.com>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Cc: ricknu-0@student.ltu.se, linux-kernel@vger.kernel.org, akpm@osdl.org,
       jeff@garzik.org, adobriyan@gmail.com, vlobanov@speakeasy.net,
       jengelh@linux01.gwdg.de, getshorty_@hotmail.com,
       pwil3058@bigpond.net.au, mb@bu3sch.de, penberg@cs.helsinki.fi,
       stefanr@s5r6.in-berlin.de, larsbj@gullik.net
Subject: Re: [RFC][PATCH] A generic boolean (version 6)
Message-Id: <20060726210020.a2b94ad0.pj@sgi.com>
In-Reply-To: <20060727021047.GG28284@filer.fsl.cs.sunysb.edu>
References: <1153341500.44be983ca1407@portal.student.luth.se>
	<1153945705.44c7d069c5e18@portal.student.luth.se>
	<20060726180622.63be9e55.pj@sgi.com>
	<20060727021047.GG28284@filer.fsl.cs.sunysb.edu>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josef wrote:
> You probably have said it before, but why do we need this?

Well, Richard should answer this, more than me.  He's the one who
braved this latest charge against a topic of much prior debate.

And I'm unsure what part of the above you wonder the reason for.

Ignoring all that ... my motivation is thus.

We've got umpteen ways of spelling and defining boolean types.  Code
would be more consistent, clear and clean if we had one way of spelling
it uniformly, through the kernel.  For example, Andrew's failed assault
on this topic in March was motivated by a build failure, when a couple
of variant spellings collided.

Some of us, apparently a majority, though the minority includes some
respected and vocal citizens of long standing, find it clearer to
explicitly code boolean types using some variant of bool/false/true,
rather than implicitly in the traditional C style of int/0/1.

C99 has added a native _Bool, along with a stdbool.h that defines
bool/false/true, and C++ has always had a native bool/false/true type.
So, despite Andrew's attempt in March to standardize on spelling
these values as FALSE/TRUE, the C99 spelling of false/true seems to
be carrying the day.

With C99's _Bool and a typedef of 'bool' for _Bool, we have a gcc
supported (for some definition of support ;) 'bool'.

But we need either #defines or an enum to spell false and true.
Since the enum provides greater opportunities for type checking,
that appears to be winning the day.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
