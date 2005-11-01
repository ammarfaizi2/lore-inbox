Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbVKAWYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbVKAWYJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 17:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbVKAWYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 17:24:09 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:60342 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751346AbVKAWYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 17:24:08 -0500
Date: Tue, 1 Nov 2005 14:24:03 -0800
From: Paul Jackson <pj@sgi.com>
To: "JaniD++" <djani22@dynamicweb.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpuset - question
Message-Id: <20051101142403.4b0897c9.pj@sgi.com>
In-Reply-To: <03c501c5df2c$9a19e2f0$0400a8c0@dcccs>
References: <035101c5df17$223eccb0$0400a8c0@dcccs>
	<20051101123648.5743a5cf.pj@sgi.com>
	<03c501c5df2c$9a19e2f0$0400a8c0@dcccs>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In this config i need NUMA option enabled to use cpusets?

No - if you got this far, cpusets are working for you.

You would need NUMA if you had multiple memory nodes.

I'm guessing you have one collection of RAM modules,
all equally distant from the processors, which is not
a NUMA (Non-Uniform-Memory-Architecture) system.

I only mentioned NUMA because if you did have NUMA
hardware, then you would need to CONFIG it into to
your kernel to make full use of your multiple memory
nodes.  I doubt that applies to you.

It looks like you have multiple (4 logical with HT)
CPUs, numbered 0, 1, 2, and 3, and one Memory Node,
numbered 0.

Cpusets should work for you - just "echo 0", not "echo 1"
into the "mems" files.  Your one and only Memory Node
is numbered "0", not "1".

Actually, make that "/bin/echo", not "echo", so you can
see the error messages.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
