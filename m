Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWH1Tpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWH1Tpr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 15:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWH1Tpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 15:45:47 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:59788 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751095AbWH1Tpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 15:45:47 -0400
Date: Mon, 28 Aug 2006 21:45:45 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       debian-user@lists.debian.org
Subject: Re: 2.6.17.6 i810 + drm:810_wait_ring - kernel crash, help?
Message-ID: <20060828194545.GA24282@rhlx01.fht-esslingen.de>
References: <Pine.LNX.4.64.0608281515250.29490@p34.internal.lan> <Pine.LNX.4.64.0608281520120.29490@p34.internal.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608281520120.29490@p34.internal.lan>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 28, 2006 at 03:20:32PM -0400, Justin Piszcz wrote:
> Alan, you seemed to have worked with this issue before?
> 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0303.0/0644.html
> 
> Any idea to its root cause?

This is an old issue that has been discussed too many times on the
internet ("i810_wait_ring": 542 results). It's simply broken OpenGL/3D
SMP locking in the i810 AGP or DRI/DRM (whatever) driver module
which thus fails catastrophically sometimes on SMT/SMP machines
after OpenGL got invoked.

The solution IIRC is to not load the kernel module named i810something,
but (if you need that functionality at all) the new, properly working
i865(?) instead.

Why I know all this? Don't ask, it's obvious... ;{

Or are you asking what to *really* do about this unfortunate
situation to make sure it can never happen again on any box? 

Andreas Mohr
