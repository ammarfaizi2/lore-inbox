Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264933AbUAVTWo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 14:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266281AbUAVTWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 14:22:43 -0500
Received: from mxsf03.cluster1.charter.net ([209.225.28.203]:9480 "EHLO
	mxsf03.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S264933AbUAVTWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 14:22:41 -0500
Date: Thu, 22 Jan 2004 14:19:53 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Nvidia drivers and 2.6.x kernel
Message-ID: <20040122191953.GA16677@forming>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200401221012.17121.chakkerz@optusnet.com.au> <200401211744.04064.paul@misner.org> <200401221105.12148.chakkerz@optusnet.com.au> <200401211824.10470.paul@misner.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401211824.10470.paul@misner.org>
X-Editor: GNU Emacs 21.1
X-Operating-System: Debian GNU/Linux 2.6.1-rc1-mm1-vesa i686
X-Uptime: 14:10:14 up 3 days, 11:29,  6 users,  load average: 7.27, 6.26, 5.64
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Josh McKinney <forming@charter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On approximately Wed, Jan 21, 2004 at 06:24:10PM -0600, Paul Misner wrote:
> On Wednesday 21 January 2004 06:05 pm, Christian Unger wrote:
> > About module-init-tools ... dunno ... never heard of it, I'm on Slackware
> > 9.1 so ... dunno ... Not sure. But like you say, if i could not initalize
> > modules the nvidia module should be the least of my worries, plus
> > everything loads in 2.4.22
> 
> The 2.6 kernel needs new tools to load the kernel modules, because they have a 
> different format (not just a different extension with .ko).  
> module-init-tools provides those necessary upgrades, and also aids in 
> creating /etc/modprobe.conf, which is used instead of /etc/modules.conf under 
> the 2.6 kernels for loading modules on startup.  If you don't have 
> module-init-tools, then I'm not surprised you are having problems.  You 
> probably need an updated mkinitrd as well if you are using an initrd on 
> system startup.
> 
> They should be at http://www.kernel.org/pub/linux/kernel/people/rusty/modules/
> 
> You probably want to read a document that summarized the changes that happened 
> in 2.6, which is where the link above was located.  It is 
> http://www.linux.org.uk/~davej/docs/post-halloween-2.6.txt
> 
> Not knowing much about Slackware, I couldn't give you much help about where 
> the best place to get your tools from might be, except for the source above.
> 
> > > What messages do you get about what is going wrong?  What happens when
> > > you so a modprobe nvidia?  What does your log file from XFree show?
> >
> > on make install i get:
> > FATAL: Error inserting nvidia (/lib/modules/2.6.1/kernel/drivers/video/
> > nvidia.ko): Invalid module format
> >
> > That's the same thing that modprobe nvidia gets.
> > I'll check the nv thing out.
> >

My guess is you need to have a "built" kernel tree.  Basically just
build the kernel, install, reboot, then without touching the kernel
tree you built rebuild the nvidia driver.  I hope that makes sense.

-- 
Josh McKinney		     |	Webmaster: http://joshandangie.org
--------------------------------------------------------------------------
                             | They that can give up essential liberty
Linux, the choice       -o)  | to obtain a little temporary safety deserve 
of the GNU generation    /\  | neither liberty or safety. 
                        _\_v |                          -Benjamin Franklin
