Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268176AbUIPQIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268176AbUIPQIs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 12:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268162AbUIPQHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 12:07:54 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:61087 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268239AbUIPQEU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 12:04:20 -0400
Date: Thu, 16 Sep 2004 09:03:22 -0700
From: Paul Jackson <pj@sgi.com>
To: Simon Derr <Simon.Derr@bull.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch] cpusets: fix race in cpuset_add_file()
Message-Id: <20040916090322.6861d402.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.61.0409161715550.5423@openx3.frec.bull.fr>
References: <20040916012913.8592.85271.16927@sam.engr.sgi.com>
	<Pine.LNX.4.61.0409161548040.5423@openx3.frec.bull.fr>
	<20040916075501.20c3ee45.pj@sgi.com>
	<Pine.LNX.4.61.0409161715550.5423@openx3.frec.bull.fr>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon wrote:
> However, your remark is welcome, since there is indeed a slight chance of 
> deadlock with my patch, but it needs 2 mkdirs racing.

Glad my confusions led to some good.

Let me think about this one a bit.

I had it in my brain that the cpuset_sem should be held across the
entire cpuset_populate_dir(), as if there would be a problem with
another task getting this lock while a directory was half populated.

But I don't know if that was a valid concern, or just a superstition on
my part.  I'll stare at this a bit more, and get back to you, either
way.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
