Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261958AbTCQVgM>; Mon, 17 Mar 2003 16:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261962AbTCQVgM>; Mon, 17 Mar 2003 16:36:12 -0500
Received: from air-2.osdl.org ([65.172.181.6]:48333 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261958AbTCQVgL>;
	Mon, 17 Mar 2003 16:36:11 -0500
Subject: Re: modutils for 2.5
From: Stephen Hemminger <shemminger@osdl.org>
To: Bob Miller <rem@osdl.org>
Cc: jlnance@unity.ncsu.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030317214018.GA13643@doc.pdx.osdl.net>
References: <Pine.LNX.4.51.0303171931220.29964@dns.toxicfilms.tv>
	 <Pine.LNX.4.51.0303171939040.15852@dns.toxicfilms.tv>
	 <20030317190136.GB10775@doc.pdx.osdl.net> <20030317193711.GA28719@ncsu.edu>
	 <20030317214018.GA13643@doc.pdx.osdl.net>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1047937622.1124.2.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 17 Mar 2003 13:47:03 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-17 at 13:40, Bob Miller wrote:
> On Mon, Mar 17, 2003 at 02:37:11PM -0500, jlnance@unity.ncsu.edu wrote:
> > On Mon, Mar 17, 2003 at 11:01:36AM -0800, Bob Miller wrote:
> > > Yes there is.  Look in:
> > > 
> > > 	ftp.kernel.org://pub/linux/kernel/people/rusty/modules
> > 
> > Any idea if installing this break a redhat-8 kernel upgrade?  I
> > updated modutils some time ago and it does not seem very happy
> > with 2.4 kernels now.  I was using RPMs because I want to keep
> > the package manager informed about which packages are installed.
> > Perhaps there was a problem with the way the RPMs were made rather
> > than the tools.
> > 
> 
> Please read the README that comes with the package, it explains this
> and other issues in more detail. In a nut shell you will need to save
> away the currently installed tools so they can be used by "older" kernels.
> 
> The makefile that comes with the package has targets that do the "right
> thing".  Please read the README.

Have seen a problem with the Redhat kernel upgrade after installing new
modutils.  Basically, the problem is that the kernel updater will
install a new kernel, and build a new init ram disk (initrd), but the
2.5 version of modprobe/insmod will get put in the ram disk instead of
the 2.4 version (modprobe.old).  This is fixable, but a nuisance.


