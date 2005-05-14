Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262816AbVENR6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262816AbVENR6S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 13:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbVENR6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 13:58:17 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:28073 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262816AbVENR6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 13:58:02 -0400
Date: Sat, 14 May 2005 10:57:16 -0700
From: Paul Jackson <pj@sgi.com>
To: vatsa@in.ibm.com
Cc: dipankar@in.ibm.com, dino@in.ibm.com, ntl@pobox.com, akpm@osdl.org,
       lse-tech@lists.sourceforge.net, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [Lse-tech] Re: [PATCH] cpusets+hotplug+preepmt broken
Message-Id: <20050514105716.69ff1745.pj@sgi.com>
In-Reply-To: <20050514160945.GA32720@in.ibm.com>
References: <20050511191654.GA3916@in.ibm.com>
	<20050511195156.GE3614@otto>
	<20050513123216.GB3968@in.ibm.com>
	<20050513172540.GA28018@in.ibm.com>
	<20050513125953.66a59436.pj@sgi.com>
	<20050513202058.GE5044@in.ibm.com>
	<20050513135233.6eba49df.pj@sgi.com>
	<20050513210251.GI5044@in.ibm.com>
	<20050513195851.5d6665d0.pj@sgi.com>
	<20050514160945.GA32720@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa wrote:
> We don't bother about arch'es which dont support CPU Hotplug. 
> ...
> Apart from being buggy on this count (that they don't lock_cpu_hotplug
> and/or don't check return value), they will also be buggy if ...

Ok.  That makes sense.

Though it is a bit worrisome.

One of the two key ways to document something is to have all existing
code examples doing it the right way.  Then someone adding a new
architecture, or adding hotplug to an existing architecture, will tend
to do the right thing, simply by doing what others have done.

Here we seem to have some cases where the "normal" ways to code some
things are broken for hotplug.  But most of the arch's still have the
broken code patterns.

The other way to document something is with comments and Doc files.

It would seem that hotplug still has opportunities for improvement,
on both fronts.

Good luck ;).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
