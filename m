Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbUKHXLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbUKHXLo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 18:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbUKHXLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 18:11:44 -0500
Received: from main.gmane.org ([80.91.229.2]:48325 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261295AbUKHXLf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 18:11:35 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: Fix IO access in rivafb
Date: Tue, 9 Nov 2004 00:07:58 +0100
Message-ID: <MPG.1bfa1abaf653d37c98970a@news.gmane.org>
References: <200411080521.iA85LbG6025914@hera.kernel.org> <1099893447.10262.154.camel@gaston> <200411081706.55261.adaplas@hotpop.com> <1099950722.10262.166.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 82.53.33.104
User-Agent: MicroPlanet-Gravity/2.70.2067
Cc: linux-fbdev-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> On Mon, 2004-11-08 at 17:06 +0800, Antonino A. Daplas wrote:
> 
> > 
> > How about this patch?  This is almost the original macro in riva_hw.h,
> > with the __force annotation.
> 
> I don't like it neither. It lacks barriers. the rivafb driver
> notoriously lacks barriers, except in a few places where it was so bad
> that it actually broke all the time, where we added some. This
> originates from the X "nv" driver written by Mark Vojkovich who didn't
> want to hear about barriers for perfs reasons I think.

Could this be the reason why in 2.6.7 I get solid lockups when 
switching to nv-driven X and rivafb-driven console? Is there 
something I could test to see if this is the reason?

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

