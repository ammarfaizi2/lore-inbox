Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267615AbTBLUQZ>; Wed, 12 Feb 2003 15:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267623AbTBLUQZ>; Wed, 12 Feb 2003 15:16:25 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:57874 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267615AbTBLUQY>; Wed, 12 Feb 2003 15:16:24 -0500
Date: Wed, 12 Feb 2003 20:26:10 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: Antonino Daplas <adaplas@pol.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: fbcon scrolling madness + fbset corruption
In-Reply-To: <20030202195744.C32007@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0302122024310.31435-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So it looks like something isn't limiting the yoffset in the generic
> console layer; an xoffset of 2392 when the maximum virtual Y is 1632
> is just nonsense.

I'm going to need to do some heavy cleaning in the next few days.

> I also noticed an additional problem with fbcon: if I change the
> resolution using fbset, the change occurs, except I end up with
> corrupted mess on the screen (the reminents of the original display.)
> The shell prompt is nowhere to be seen.
>
> Hitting ^L clears the screen and then the shell prompt is visiable.

The method to use now is stty to change the console mode. It works :-)
fbset is used to change the variable the vt terminals are not familiar 
with such as bpp.

