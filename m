Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753201AbWKGVvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201AbWKGVvl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 16:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753241AbWKGVvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 16:51:41 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:45703 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1753201AbWKGVvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 16:51:40 -0500
Date: Tue, 7 Nov 2006 13:50:54 -0800
From: Paul Jackson <pj@sgi.com>
To: "Paul Menage" <menage@google.com>
Cc: vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-Id: <20061107135054.bbc584f9.pj@sgi.com>
In-Reply-To: <6599ad830611071241p255b205em52ed3ba13e02cdc2@mail.gmail.com>
References: <20061030031531.8c671815.pj@sgi.com>
	<20061031115342.GB9588@in.ibm.com>
	<6599ad830610310846m5d718d22p5e1b569d4ef4e63@mail.gmail.com>
	<20061101172540.GA8904@in.ibm.com>
	<6599ad830611011537i2de812fck99822d3dd1314992@mail.gmail.com>
	<20061106124948.GA3027@in.ibm.com>
	<6599ad830611061223m77c0ef1ei72bd7729d9284ec6@mail.gmail.com>
	<20061107104118.f02a1114.pj@sgi.com>
	<6599ad830611071107u4226ec17h5facc7ee2ad53174@mail.gmail.com>
	<20061107123458.e369f62a.pj@sgi.com>
	<6599ad830611071241p255b205em52ed3ba13e02cdc2@mail.gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul M wrote:
> Is it possible to dynamically extend the /proc/<pid>/ directory?

Not that I know of -- sounds like a nice idea for a patch.

> We're currently planning on using cpusets for the memory node
> isolation properties, but we have a whole bunch of other resource
> controllers that we'd like to be able to hang off the same
> infrastructure, so I don't think the need is that limited.

So long as you can update the code in your user space stack that
knows about this, then you should have nothing stopping you.

I've got a major (albeit not well publicized) open source user space
C library for working with cpusets which I will have to fix up.

> The naming is already in my patch. You can tell from the top-level
> directory which containers are registered, since each one has an
> xxx_enabled file to control whether it's in use;

But there are other *_enabled per-cpuset flags, not naming controllers,
so that is not a robust way to list container types.

Right now, I'm rather fond of the /proc/containers (or should it
be /proc/controllers?) idea.  Though since I don't time to code
the patch today, I'll have to shut up.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
