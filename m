Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265433AbUFDB1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265433AbUFDB1R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 21:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265407AbUFDB1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 21:27:17 -0400
Received: from havoc.gtf.org ([216.162.42.101]:29624 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S265484AbUFDB1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 21:27:09 -0400
Date: Thu, 3 Jun 2004 21:26:56 -0400
From: David Eger <eger@havoc.gtf.org>
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: David Eger <eger@theboonies.us>, adaplas@pol.net,
       Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] [PATCH] fb accel capabilities (resend against 2.6.7-rc2)
Message-ID: <20040604012655.GA29263@havoc.gtf.org>
References: <20040603023653.GA20951@havoc.gtf.org> <200406032307.13121.adaplas@hotpop.com> <1086285678.40bf676e1da4d@mail.theboonies.us> <40BF8E10.5020107@winischhofer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BF8E10.5020107@winischhofer.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2004 at 10:46:08PM +0200, Thomas Winischhofer wrote:
> David Eger wrote:
> >
> >On the down side, panning makes screen corruption for me... time to 
> >investigate to see if fbcon or radeonfb is to blame... perhaps panning 
> >is just ncompatible with accel engine at all in radeon...
> 
> What sort of "screen corruption" do you get?

I tracked it down in the radeon accel code -- the fix wasn't hard.  
by default, radeon allocs a virtual screen the same size as the screen,
so I just hadn't encountered the bug yet ;-)

Patches implementing Antonino's pseudocode and fixing radeonfb are coming
momentarily.  Thank you Antonino.

-dte
