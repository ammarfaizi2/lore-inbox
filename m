Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbVAGSOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbVAGSOU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 13:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVAGSNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 13:13:39 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:47251 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261372AbVAGSLb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 13:11:31 -0500
Date: Fri, 7 Jan 2005 10:11:31 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, paulmck@us.ibm.com,
       arjan@infradead.org, linux-kernel@vger.kernel.org, jtk@us.ibm.com,
       wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com, linux@brodo.de
Subject: Re: [PATCH] add feature-removal-schedule.txt documentation
Message-ID: <20050107181131.GA29152@kroah.com>
References: <20050106190538.GB1618@us.ibm.com> <1105039259.4468.9.camel@laptopd505.fenrus.org> <20050106201531.GJ1292@us.ibm.com> <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk> <20050106210408.GM1292@us.ibm.com> <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk> <20050106152621.395f935e.akpm@osdl.org> <20050106235633.GA10110@kroah.com> <41DEC0BF.4010708@osdl.org> <Pine.LNX.4.58.0501070949410.2272@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501070949410.2272@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 09:54:16AM -0800, Linus Torvalds wrote:
> 
> 
> On Fri, 7 Jan 2005, Randy.Dunlap wrote:
> > 
> > Brodo, can you add a little more info to this, please?
> 
> I think for something like this to be really useful, you should not just
> say "can be replaced with Xxxx", but have some docs (or pointers to such)
> for both users and developers (depending on who is affected) on _how_ to 
> replace it, or fix it.
> 
> Also, I'm not convinced about the single-file format. If we want to do
> this (I don't know how much it buys, but hey, I certainly also don't have
> any objections), I think it would be much nicer to have a separate 
> "deprecated" subdirectory, with one file per issue. 

Ok, that's fine with me, makes it easier for patches.  I'll take my
writeup and Randy's and split them out.

> (Not that I think it necessarily needs to be just about deprecated or 
> removed features - again, if we do this, I don't see why it shouldn't 
> contain the same information about semantic changes, so that when the 
> locking for an interface changes, you could have a
> 
> 	Documentation/changes/vfs-ioctl-locking.txt
> 
> that tells what the new rules are).

Hm, but things "change" all the time.  "new" rules become "old" rules
over time too.  What should probably happen is the proper rules are
documented and kept up to date, like they are today in
Documentation/filesystems/Locking and Documentation/pci.txt as two
examples.  Showing what has changed over time in those two files is what
diffs are for :)

Otherwise, the kernel changelogs are good places to dig for changes in
apis, but do we really want to duplicate this in other places too?

thanks,

greg k-h
