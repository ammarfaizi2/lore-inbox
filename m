Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267803AbUG3TmC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267803AbUG3TmC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 15:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267807AbUG3TmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 15:42:02 -0400
Received: from web14927.mail.yahoo.com ([216.136.225.85]:36236 "HELO
	web14927.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267803AbUG3Tlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 15:41:50 -0400
Message-ID: <20040730194150.7072.qmail@web14927.mail.yahoo.com>
Date: Fri, 30 Jul 2004 12:41:50 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Exposing ROM's though sysfs
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040730193546.GA328@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I looked at PCI quirks, they all seem to be fixing chipset issues. Do
we want to start including adapter specific quirks along with the more
general chipset one?

--- Vojtech Pavlik <vojtech@suse.cz> wrote:

> On Fri, Jul 30, 2004 at 12:25:10PM -0700, Jon Smirl wrote:
> > --- Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> > > How about this patch?
> > 
> > Here's the ROM access code I've been using but it's not in the form
> > that we need.
> > 
> > We do need a standard scheme for the radeon situation of having a
> bug
> > in the ROM access logic. Is it ok to put the fix for this in the
> radeon
> > driver? So if you read the ROM before the driver is loaded it won't
> be
> > there (proabably FFFF's). After the driver loads the fix will run
> as
> > part of the driver init and the ROM access functions will work
> right. 
> 
> IMO the fix should go to the PCI quirk logic. That's a place to work
> around PCI config bugs.
> 
> -- 
> Vojtech Pavlik
> SuSE Labs, SuSE CR
> 


=====
Jon Smirl
jonsmirl@yahoo.com


	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 
