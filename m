Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbVARMVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVARMVc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 07:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVARMVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 07:21:32 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41638 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261265AbVARMV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 07:21:26 -0500
Date: Tue, 18 Jan 2005 12:21:26 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Greg KH <greg@kroah.com>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: PCI patches not being reviewed
Message-ID: <20050118122126.GM30982@parcelfarce.linux.theplanet.co.uk>
References: <20050118022031.GL30982@parcelfarce.linux.theplanet.co.uk> <20050118062721.GA8951@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118062721.GA8951@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 10:27:22PM -0800, Greg KH wrote:
> On Tue, Jan 18, 2005 at 02:20:31AM +0000, Matthew Wilcox wrote:
> > 
> > Greg, you're merging a lot of patches that aren't going through
> > the linux-pci mailing list for review.  Please redirect patches that
> > are sent to you directly so others can also review them.
> 
> I'm sorry, were there any that were recently applied that you feel
> needed more review?

Yes, the PCI Express bridge driver is quite buggy.  I also think it's
the wrong approach to take -- weren't you working on a generic way to
have multiple drivers attach to the same device?

> All major ones have been posted to linux-kernel
> first, which, according to the MAINTAINERS file, is the list for pci
> issues to be disccused on.  I'd be glad to change that entry, if you
> think it would help out any.

That would certainly help; I'm not sure how anyone has time to read
linux-kernel.  Here's a patch:

Index: linux-2.6/MAINTAINERS
===================================================================
RCS file: /var/cvs/linux-2.6/MAINTAINERS,v
retrieving revision 1.34
diff -u -p -r1.34 MAINTAINERS
--- linux-2.6/MAINTAINERS	12 Jan 2005 20:14:52 -0000	1.34
+++ linux-2.6/MAINTAINERS	18 Jan 2005 12:16:43 -0000
@@ -1745,7 +1745,7 @@ S:	Maintained
 PCI SUBSYSTEM
 P:	Greg Kroah-Hartman
 M:	greg@kroah.com
-L:	linux-kernel@vger.kernel.org
+L:	linux-pci@atrey.karlin.mff.cuni.cz
 S:	Supported
 
 PCI HOTPLUG CORE

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
