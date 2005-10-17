Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbVJQVkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbVJQVkv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 17:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbVJQVkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 17:40:51 -0400
Received: from waste.org ([216.27.176.166]:14501 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932343AbVJQVku (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 17:40:50 -0400
Date: Mon, 17 Oct 2005 14:39:16 -0700
From: Matt Mackall <mpm@selenic.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Esben Nielsen <simlo@phys.au.dk>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: ketchup+rt with ktimers added.
Message-ID: <20051017213915.GN26160@waste.org>
References: <Pine.LNX.4.58.0510170316310.5859@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510170316310.5859@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 03:38:49AM -0400, Steven Rostedt wrote:
> 
> Here's another update patch to ketchup based on Michal Schmidts patched
> version of Matt Mackall's ketchup at
> http://www.uamt.feec.vutbr.cz/rizeni/pom/ketchup-0.9+rt
> This patch adds Thomas Gleixner's ktimers (both base kt and HRT versions).

Thomas has indicated that these trees might not be very long-lived. So
instead, I've added the ability to make local extensions:

.ketchuprc:

local_trees = {
    '2.6-kt': (latest_dir,
               "http://www.tglx.de/projects/ktimers/patch-%(full)s.patch",
               r'patch-(2.6.*?)',
               0, "Thomas Gleixner's ktimers."),
    '2.6-kthrt': (latest_dir,
                  "http://www.tglx.de/projects/ktimers/patch-%(full)s.patch",
                  r'patch-(2.6.*?)',
                  0, "Thomas Gleixner's ktimers and HRT patches.")
    }

$ ./ketchup -s 2.6-kt
2.6.14-rc4-kthrt3.patch

> Since the base version of Michal Schmidt's ketchup-0.9+rt didn't include
> Esben Nielsen's addition of handling Ingo's older kernels, I again
> included it with this patch.

That's been in tip for a while:

http://selenic.com/repo/ketchup/

-- 
Mathematics is the supreme nostalgia of our time.
