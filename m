Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264398AbUFNVMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264398AbUFNVMW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 17:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264444AbUFNVMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 17:12:22 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:4215 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264398AbUFNVMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 17:12:08 -0400
Date: Mon, 14 Jun 2004 14:21:28 -0700
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@muc.de>
Cc: anton@samba.org, ak@muc.de, linux-kernel@vger.kernel.org,
       lse-tech@projects.sourceforge.net
Subject: Re: NUMA API observations
Message-Id: <20040614142128.4da12a8d.pj@sgi.com>
In-Reply-To: <20040614161749.GA62265@colin2.muc.de>
References: <20040614153638.GB25389@krispykreme>
	<20040614161749.GA62265@colin2.muc.de>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi wrote:
> How should a user space application sanely discover the cpumask_t
> size needed by the kernel?  Whoever designed that was on crack.
> 
> I will probably make it loop and double the buffer until EINVAL
> ends or it passes a page and add a nasty comment.

I agree that a loop is needed.  And yes someone didn't do a very
good job of designing this interface.

I posted a piece of code that gets a usable upper bound on cpumask_t
size, suitable for application code to size mask buffers to be used
in these system calls.

See the lkml article:

  http://groups.google.com/groups?selm=fa.hp225re.1v68ei0%40ifi.uio.no

Or search in google groups for "cpumasksz".

This article was posted:

    Date: 2004-06-04 09:20:13 PST 

in a long thread under the Subject of:

    [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based implementation

Feel free to steal it, or to ignore it, if you find it easier to
write your version than to read mine.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
