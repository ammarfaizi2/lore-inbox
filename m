Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268592AbUIQJMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268592AbUIQJMT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 05:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268609AbUIQJMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 05:12:19 -0400
Received: from zeus.kernel.org ([204.152.189.113]:27045 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S268592AbUIQJL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 05:11:57 -0400
Date: Fri, 17 Sep 2004 02:10:37 -0700
From: Paul Jackson <pj@sgi.com>
To: Simon Derr <Simon.Derr@bull.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch] cpusets: fix race in cpuset_add_file()
Message-Id: <20040917021037.324e6e60.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.61.0409170932170.5423@openx3.frec.bull.fr>
References: <20040916012913.8592.85271.16927@sam.engr.sgi.com>
	<Pine.LNX.4.61.0409161548040.5423@openx3.frec.bull.fr>
	<20040916075501.20c3ee45.pj@sgi.com>
	<Pine.LNX.4.61.0409161715550.5423@openx3.frec.bull.fr>
	<20040917002232.7b4135f5.pj@sgi.com>
	<Pine.LNX.4.61.0409170932170.5423@openx3.frec.bull.fr>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon wrote:
> The result is that `ls' and `mkdir' both create a dentry for a/b/cpus

Ouch - persuasive - well presented - thanks.

On the flip side, I am not finding any firm basis in the concerns I had
that led me down the other path.

Give me a few hours to run this through a bit of unit testing on my
side, then I will likely endorse your patch.

I have two minor patches on my side:
 1) add CONFIG_CPUSETS=y to sn2_defconfig, and
 2) remove some more casts of (void *)d_fsdata.

If it's ok by you, and I don't have any more questions, I will send all
three along to Andrew, as a set, in a few hours.

Good work, Simon.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
