Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266375AbUFQFTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266375AbUFQFTu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 01:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266376AbUFQFTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 01:19:50 -0400
Received: from smtp-out5.xs4all.nl ([194.109.24.6]:51730 "EHLO
	smtp-out5.xs4all.nl") by vger.kernel.org with ESMTP id S266375AbUFQFTs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 01:19:48 -0400
Date: Thu, 17 Jun 2004 07:19:31 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: David Eger <eger@havoc.gtf.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] fix radeonfb panning and make it play nice with copyarea()
Message-ID: <20040617051931.GA1378@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <20040616182415.GA8286@middle.of.nowhere> <20040617022100.GA11774@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040617022100.GA11774@havoc.gtf.org>
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Eger <eger@havoc.gtf.org>
Date: Wed, Jun 16, 2004 at 10:21:00PM -0400
> 
> /me looks at vanilla 2.6.7
> 
> I believe the following patch will fix the bug you describe.
> (part of this patch I sent to benh before, but it never made it to 2.6.7)
> 
> Please try the following bugfix.  It works for me.
> If it works for you, I'll ask Andrew/James to merge.
> 
> -dte
> 
> 
> radeonfb: fix panning corruption on a large virtual screen,
>   Make panning and copyarea() play nicely with each other.
> 
> Signed-off-by: David Eger <eger@havoc.gtf.org>
> 
> # drivers/video/aty/radeon_base.c
> #   2004/06/17 03:47:12+02:00 eger@rosencrantz.theboonies.us +13 -0
> #   add some fifo_wait()s to lick this corruption problem
> # 
> # drivers/video/aty/radeon_accel.c
> #   2004/06/17 03:47:12+02:00 eger@rosencrantz.theboonies.us +2 -2
> #   make radeon accel play nice when the user wants to have a large virtual
> #   screen to pan on.  fix previous drain bramage.
> # 

Unfortunately, this doesn't fix it for me.

horizontal scrolling in angband is still very broken, and vertical
scrolling (even as simple as recalling previous command-lines in bash)
is also still broken.

For example, recalling the previous commandline goes OK the first time,
and the second time, part of the line is shifted some 120 characters to
the right.

Sorry,
Jurriaan
-- 
Cole's Law:
  Thinly sliced cabbage.
Debian (Unstable) GNU/Linux 2.6.7 2x6078 bogomips load 0.14
