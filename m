Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbVKOWL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbVKOWL4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 17:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbVKOWL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 17:11:56 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:10368 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932143AbVKOWLy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 17:11:54 -0500
Date: Tue, 15 Nov 2005 14:11:46 -0800
From: Paul Jackson <pj@sgi.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, frankeh@watson.ibm.com, haveblue@us.ibm.com
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Message-Id: <20051115141146.5add977c.pj@sgi.com>
In-Reply-To: <20051115190030.GA16790@sergelap.austin.ibm.com>
References: <20051114212341.724084000@sergelap>
	<20051114153649.75e265e7.pj@sgi.com>
	<20051115010155.GA3792@IBM-BWN8ZTBWAO1>
	<20051114175140.06c5493a.pj@sgi.com>
	<20051115022931.GB6343@sergelap.austin.ibm.com>
	<20051114193715.1dd80786.pj@sgi.com>
	<20051115051501.GA3252@IBM-BWN8ZTBWAO1>
	<20051114223513.3145db39.pj@sgi.com>
	<20051115081100.GA2488@IBM-BWN8ZTBWAO1>
	<20051115010624.2ca9237d.pj@sgi.com>
	<20051115190030.GA16790@sergelap.austin.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge wrote:
> restarting multiple simulatenous instances of a single
> checkpoint.  ... Is there a simple way to solve this?
> (And how valid a concern is this?  :)

Offhand, I don't see a way to resolve it in the preallocation scheme.

That's not on my list of stuff to worry about.  But, who knows,
someone else might find that a valid concern.

> Other than that, I guess your approach is growing on me...

Oh dear.  I'm drifting away from advocating a pid-range preallocation
and toward thinking we need a more systematic approach, design and
architecture.  This isn't just pids.  Simple range based preallocation
won't help much on some of the other resources that we need to virtualize.

The Zap pods are sounding good to me right now, properly embedded
in the kernel rather than hacking the syscall table via a module.

In any case, I am suspecting that starting the job in some sort
of nice container should be a prerequisite for relocating or
checkpoint/restarting the job.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
