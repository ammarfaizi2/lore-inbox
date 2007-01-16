Return-Path: <linux-kernel-owner+w=401wt.eu-S932070AbXAPEOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbXAPEOR (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 23:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbXAPEOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 23:14:16 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:57291 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932070AbXAPEOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 23:14:16 -0500
Date: Mon, 15 Jan 2007 20:14:06 -0800
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: bob.picco@hp.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CPUSET related breakage of sys_mbind
Message-Id: <20070115201406.bf67c773.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0701151950200.15083@schroedinger.engr.sgi.com>
References: <20070115231050.GA32220@localhost>
	<20070115184313.70ba25df.pj@sgi.com>
	<Pine.LNX.4.64.0701151950200.15083@schroedinger.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph wrote:
> Cpusets is your thing so I think you could fix this the right way.

But wasn't it your patch that broke ...

Actually, I'd have blessed Bob Picco's patch, as it's done the right
way, with a cpuset_* macro hook, defined twice in cpuset.h, with and
without CONFIG_CPUSET, where the without case compiles to a no-op.
This is the same way as is used for the couple dozen other cpuset
kernel hooks.

But I thought you were already signed up for this one, so I didn't want
to trample on your efforts.

And, perhaps more important, I understood you had some other patches in
the works that have cpuset hooks.  I'm thinking it would be a good idea
to learn how these hooks are done, so we don't have to come around here
again.

How about this ... you take another look at Bob's patch.  If it's ok by
you too, then we can both bless it, and that should do it.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
