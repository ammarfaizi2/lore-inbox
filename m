Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267947AbTBLXqJ>; Wed, 12 Feb 2003 18:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267948AbTBLXqJ>; Wed, 12 Feb 2003 18:46:09 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39949 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267947AbTBLXqI>; Wed, 12 Feb 2003 18:46:08 -0500
Date: Wed, 12 Feb 2003 23:55:54 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: James Simmons <jsimmons@infradead.org>
Cc: Antonino Daplas <adaplas@pol.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: fbcon scrolling madness + fbset corruption
Message-ID: <20030212235553.E16409@flint.arm.linux.org.uk>
Mail-Followup-To: James Simmons <jsimmons@infradead.org>,
	Antonino Daplas <adaplas@pol.net>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
References: <20030202195744.C32007@flint.arm.linux.org.uk> <Pine.LNX.4.44.0302122024310.31435-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0302122024310.31435-100000@phoenix.infradead.org>; from jsimmons@infradead.org on Wed, Feb 12, 2003 at 08:26:10PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2003 at 08:26:10PM +0000, James Simmons wrote:
> > So it looks like something isn't limiting the yoffset in the generic
> > console layer; an xoffset of 2392 when the maximum virtual Y is 1632
> > is just nonsense.
> 
> I'm going to need to do some heavy cleaning in the next few days.
> 
> > I also noticed an additional problem with fbcon: if I change the
> > resolution using fbset, the change occurs, except I end up with
> > corrupted mess on the screen (the reminents of the original display.)
> > The shell prompt is nowhere to be seen.
> >
> > Hitting ^L clears the screen and then the shell prompt is visiable.
> 
> The method to use now is stty to change the console mode. It works :-)
> fbset is used to change the variable the vt terminals are not familiar 
> with such as bpp.

How do I ensure that such parameters as the refresh rate, hsync width and
offset, vsync width and offset are too my liking?

I've noticed that there seems to be some variation between the parameters
used, and I'd prefer to use my set since they match the host OS (it means
I don't have to keep readjusting the screen each time I change OS.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

