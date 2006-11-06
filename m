Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753806AbWKFVKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753806AbWKFVKS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 16:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753808AbWKFVKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 16:10:18 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:40400 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1753806AbWKFVKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 16:10:16 -0500
Date: Mon, 6 Nov 2006 13:09:20 -0800
From: Paul Jackson <pj@sgi.com>
To: "Paul Menage" <menage@google.com>
Cc: balbir@in.ibm.com, sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net,
       jlan@sgi.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       mbligh@google.com, winget@google.com, rohitseth@google.com
Subject: Re: [ckrm-tech] [PATCH 2/6] Cpusets hooked into containers
Message-Id: <20061106130921.7ed66fa5.pj@sgi.com>
In-Reply-To: <6599ad830611061255u458a795bpca1c360cb93f253@mail.gmail.com>
References: <20061020183819.656586000@menage.corp.google.com>
	<20061020190626.810567000@menage.corp.google.com>
	<454ED769.8040302@in.ibm.com>
	<6599ad830611061255u458a795bpca1c360cb93f253@mail.gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul M wrote:
>  It basically makes "cpuset" an alias for "container"
> in the relevant /proc directories if CONFIG_CPUSETS_LEGACY_API is
> defined.

Paul M - I never replied to your initial CONFIG_CPUSETS_LEGACY_API
patch proposal - sorry.

An aspect of this proposal never made sense to me, so I put it aside
and went on to other things.

It is important to me that the current cpuset API be maintained.  The
cpuset API seems to be working well, for a number of users.

Occassionally I will agree to subtle API changes (see another thread
concerning cpu_exclusive and sched_domain cpuset flags), but not
anything likely to break user code outright, except under duress.

But I presume this CONFIG_CPUSETS_LEGACY_API option means I either
get to build a kernel that supports the new container API, or a kernel
that supports the old cpuset API.  That does not seem useful to me.

We need to support both API's, at runtime, at the same time.  Not a choice
of API's at build time with a kernel CONFIG option.

Perhaps I am missing something ...

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
