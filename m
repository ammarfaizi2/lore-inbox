Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261809AbSJNCnk>; Sun, 13 Oct 2002 22:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261810AbSJNCnk>; Sun, 13 Oct 2002 22:43:40 -0400
Received: from ip68-4-86-174.oc.oc.cox.net ([68.4.86.174]:19694 "EHLO
	ip68-4-86-174.oc.oc.cox.net") by vger.kernel.org with ESMTP
	id <S261809AbSJNCnj>; Sun, 13 Oct 2002 22:43:39 -0400
Date: Sun, 13 Oct 2002 19:49:30 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] 2.5.42 partial fix for older pl2303
Message-ID: <20021014024930.GE10921@ip68-4-86-174.oc.oc.cox.net>
References: <20021009233624.GA17162@ip68-4-86-174.oc.oc.cox.net> <20021009235332.GA19351@kroah.com> <20021011023925.GA9142@ip68-4-86-174.oc.oc.cox.net> <20021011170623.GB4123@kroah.com> <20021012063036.GA10921@ip68-4-86-174.oc.oc.cox.net> <20021012205604.GB17162@ip68-4-86-174.oc.oc.cox.net> <20021013004249.GC17162@ip68-4-86-174.oc.oc.cox.net> <20021013011644.GA12720@kroah.com> <20021013043008.GD10921@ip68-4-86-174.oc.oc.cox.net> <20021013202504.GA23533@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021013202504.GA23533@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2002 at 01:25:04PM -0700, Greg KH wrote:
> Nice, I've added this to my tree.  I also made the following patch, to
> fix up the proper return value for the probe() call, and fix a memory
> leak.
> 
> Let me know if this patch causes any problems for you.

On the contrary, the percentage of non-working PL-2303 opens has now
gone from 50% to somewhere in the 5-15% range (rough guess). IOW, it's
working better than my previous patch.

FWIW, I'm seeing some "sleeping function called from illegal context"
oopses, but I didn't see if those were happening with my old patch. I'll
test with your latest batch of USB changes later (after they get merged
by Linus, most likely).

-Barry K. Nathan <barryn@pobox.com>
