Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262533AbVDGRun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262533AbVDGRun (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 13:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbVDGRun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 13:50:43 -0400
Received: from inutil.org ([193.22.164.111]:969 "EHLO
	vserver151.vserver151.serverflex.de") by vger.kernel.org with ESMTP
	id S262533AbVDGRud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 13:50:33 -0400
Date: Thu, 7 Apr 2005 19:50:26 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc2
Message-ID: <20050407175026.GA5872@informatik.uni-bremen.de>
References: <Pine.LNX.4.58.0504040945100.32180@ppc970.osdl.org> <Pine.LNX.4.58.0504041430070.2215@ppc970.osdl.org> <E1DJE6t-0001T5-UD@localhost.localdomain> <1112827342.9567.189.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112827342.9567.189.camel@gaston>
User-Agent: Mutt/1.5.8i
From: Moritz Muehlenhoff <jmm@inutil.org>
X-SA-Exim-Connect-IP: 84.137.105.158
X-SA-Exim-Mail-From: jmm@inutil.org
X-SA-Exim-Scanned: No (on vserver151.vserver151.serverflex.de); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> > 1. When resuming from S3 suspend and having switched off the backlight
> > with radeontool the backlight isn't switched back on any more.
> 
> I'm not sure what's up here, it's a nasty issue with backlight. Can
> radeontool bring it back ?

Before suspending I power down the backlight with "radeontool light off"
and with 2.6.11 the display is properly restored. With 2.6.12rc2 the
backlight remains switched off and if I switch it on with radeontool it
becomes lighter, but there's still no text from the fbcon, just the blank
screen.

> > 2. I'm using fbcon as my primary work environment, but tty switching has
> > become _very_ sloppy, it's at least a second now, while with 2.6.11 it
> > was as fast as a few ms. Is this caused by the "proper PLL accesses"?
> 
> Yes. Unfortunately. It's surprised it is that slow though, there
> shouldn't be more than 5 or 6 PLL accesses on a normal mode switch, with
> 5ms pause for each, that should still be very reasonable. It looks like
> we are doing a lot more accesses which I don't completely understand.

Can you tell me which function you have in mind, so that I can insert
some printks to see how often it's called?

Cheers,
        Moritz
