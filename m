Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265710AbTL3KHf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 05:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265716AbTL3KHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 05:07:34 -0500
Received: from gprs178-245.eurotel.cz ([160.218.178.245]:35714 "EHLO
	midnight.ucw.cz") by vger.kernel.org with ESMTP id S265710AbTL3KHY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 05:07:24 -0500
Date: Tue, 30 Dec 2003 11:07:45 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Spurious double-clicks in 2.6.0
Message-ID: <20031230100745.GA951@ucw.cz>
References: <200312292354.15084.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312292354.15084.rob@landley.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 29, 2003 at 11:54:14PM -0600, Rob Landley wrote:
> I recently had the opportunity to compare 2.6 and 2.4 on my thinkpad, and 
> although most things are greatly improved in 2.6, one thing stands out.
> 
> When I click on things in 2.6, about 1% of the time it double-clicks instead.  
> (Clicking on a titlebar to raise the window causes it to roll up instead, 
> clicking on a scrollbar causes it to page down twice instead of once, etc.  
> I'm always afraid that pulling up the top left window menu (to move it to 
> another desktop, make it always on top, etc) will kill the window instead...)
> 
> This just doesn't happen under 2.4: I used the default kernel of Fedora Core 1 
> for several days after a recent reinstall before putting 2.6 back on the box.  
> But the input core doesn't seem to have this detail yet.
> 
> In 2.4 there seems to be some minimum time required between clicks to count as 
> a double-click, which nicely filters out this kind of suprious electrical 
> contact bounce thing.  (This makes sense: a human being simply CAN'T click 
> twice within 1/20th of a second.  The mouse driver should drop a second click 
> that comes faster than that: it's keybounce from the previous click.)

Reconfigure X only to use one mouse source (either /dev/psaux or
/dev/input/mice, not both). Since in 2.6 the mouse inputs are already
mixed in the kernel for these two devices, X then gets all the data
twice, resulting in random doubleclicks.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
