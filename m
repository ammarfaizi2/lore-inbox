Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264465AbTFPX5Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 19:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264469AbTFPX5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 19:57:24 -0400
Received: from host151.spe.iit.edu ([198.37.27.151]:36755 "EHLO
	found.lostlogicx.com") by vger.kernel.org with ESMTP
	id S264465AbTFPX5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 19:57:23 -0400
Date: Mon, 16 Jun 2003 19:11:14 -0500
From: Brandon Low <lostlogic@gentoo.org>
To: Peter Osterlund <petero2@telia.com>
Cc: Thomas Molina <tmolina@cox.net>, linux-kernel@vger.kernel.org
Subject: Re: presario laptop and 2.5.71
Message-ID: <20030617001114.GC25761@lostlogicx.com>
References: <Pine.LNX.4.44.0306151511290.1056-100000@lap.molina> <m2llw2lh7l.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2llw2lh7l.fsf@telia.com>
X-Operating-System: Linux found.lostlogicx.com 2.4.20-pfeifer-r1_pre7
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nope, not a build problem (AFAICS) under 2.5.70-mm9, I was able to use
the new synaptics driver pretty well (seems to have some sync problems)
whatever changed in that department before 2.5.71/(-mm1) broke it, now
the driver loads, correct detects my touchpad, but never binds it to the
event interface (I did not modularize the event interface, and touchpad
stuff because under 2.5.70 there WAS a buildproblem wherein the psmouse
module couldn't be built as a module).

Hope this additional info either helps someone solve the problem or at
least clears up that there IS a problem...

--Brandon Low
Gentoo Developer

On Mon, 06/16/03 at 07:33:18 +0200, Peter Osterlund wrote:
> Thomas Molina <tmolina@cox.net> writes:
> 
> > I have two problems with 2.5.71 and my Presario 12XL325 laptop.  
> > 
> > Problem one is that my synaptics mousepad does not work.  Previously, it 
> > was recognized as a PS/2 device.  With this kernel I get nothing.  I am 
> > including my configuration.  I've tried with the synaptics-specific driver 
> > loaded as well as simply just using the generic ps/2 support which has 
> > worked in the past.
> > 
> I think this is some kind of build problem. The messages you quote
> should not even be compiled into the kernel if you disable
> CONFIG_MOUSE_PS2_SYNAPTICS in the kernel configuration.
> 
> Also note that this driver needs user space support, see:
> 
>         http://w1.894.telia.com/~u89404340/touchpad/index.html
> 
> Also make sure the evdev module is loaded.
