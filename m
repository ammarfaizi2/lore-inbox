Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbUEFRFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbUEFRFS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 13:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbUEFRFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 13:05:18 -0400
Received: from waste.org ([209.173.204.2]:7360 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261439AbUEFRFN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 13:05:13 -0400
Date: Thu, 6 May 2004 12:05:02 -0500
From: Matt Mackall <mpm@selenic.com>
To: Valdis.Kletnieks@vt.edu
Cc: J?rn Engel <joern@wohnheim.fh-wedel.de>,
       Dominik Karall <dominik.karall@gmx.net>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
Message-ID: <20040506170501.GD28459@waste.org>
References: <20040505013135.7689e38d.akpm@osdl.org> <200405051312.30626.dominik.karall@gmx.net> <200405051822.i45IM2uT018573@turing-police.cc.vt.edu> <20040505215136.GA8070@wohnheim.fh-wedel.de> <200405061518.i46FIAY2016476@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405061518.i46FIAY2016476@turing-police.cc.vt.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 11:18:10AM -0400, Valdis.Kletnieks@vt.edu wrote:
> It's a Good Idea to do this in -mm, to flush out all the binary
> modules that are known to have issues with this (have we identified
> anybody other than NVidia that actually *has* a problem)?

Anything that uses current() or the like will be unhappy, though it
may work half the time. So just about anything binary-only is liable
to hit it. We can catch most of this by adding "4KSTACKS" to the
global build flags, but I think stuff like the Nvidia wrapper layer
shoots itself in the foot here by silently ignoring this check.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
