Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265685AbUEZOPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265685AbUEZOPD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 10:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265652AbUEZOPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 10:15:03 -0400
Received: from holomorphy.com ([207.189.100.168]:57728 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265685AbUEZOFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 10:05:17 -0400
Date: Wed, 26 May 2004 07:05:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Lenar L?hmus <lenar@vision.ee>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.x kernel sluggish behavior
Message-ID: <20040526140513.GB2764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Lenar L?hmus <lenar@vision.ee>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <40B49BD6.7050202@vision.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B49BD6.7050202@vision.ee>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2004 at 04:29:58PM +0300, Lenar L?hmus wrote:
> Overall I really like the performance and smoothness of 2.6.x kernels,
> but there has been always one problematic situation.
> It's debian here with X/KDE running. The problem manifests itself
> when one launches acroread-plugin in Mozilla or Mozilla-based browser. 
> Whatever is the reason, but when acroread is launched as browser
> plugin, it makes system quite sluggish. X process starts to consume
> about 70% of cpu time continuosly.
> That would not be a problem usually, but in this case system really 
> feels like hanging and stopping. Mouse cursor on screen stops and
> jumps and does other neat tricks.
> Drawing of pages in acroread is extremely slow. Its very very bad when 
> loaded document is some kind of marketing brochure full of
> pictures/backgrounds etc... Nothing of this when acroread is being
> run as standalone app.

What kernel version is this? Could you try with 2.6.6-mm4 if it was
less recent than that?


On Wed, May 26, 2004 at 04:29:58PM +0300, Lenar L?hmus wrote:
> Even more. This system has several terminals connected to it, and all of 
> them show same sluggish behavior same time. So it's not like X-server
> process running on system is too busy to interact with mouse or draw
> on screen.
> This behavior stops when the window with acroread is closed (or back 
> button pressed when one can direct mouse cursor to that button which
> as you can believe is very hard in this case).
> I think it's definetely a scheduler problem (although caused by 
> application bug).
> You propably need more information. Just ask. I'm happy to help to get 
> this annoying problem disappear.

Some instrumentation is likely in order. 2.6.6-mm4 has schedstats,
which you should log to get us enough information to do something about
this performance problem. Logs of vmstat, top, and snapshots of kernel
profiles, /proc/vmstat, and /proc/meminfo may also help.


-- wli
