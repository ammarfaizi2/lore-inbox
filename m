Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266248AbUBQPqb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 10:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266251AbUBQPqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 10:46:30 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:22075 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S266248AbUBQPq3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 10:46:29 -0500
Date: Tue, 17 Feb 2004 17:02:26 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Harald Dunkel <harald.dunkel@t-online.de>,
       Rusty Russell <rusty@rustcorp.com.au>
Cc: Ryan Reich <ryanr@uchicago.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.2: "-" or "_", thats the question
Message-ID: <20040217160226.GB2178@mars.ravnborg.org>
Mail-Followup-To: Harald Dunkel <harald.dunkel@t-online.de>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Ryan Reich <ryanr@uchicago.edu>, linux-kernel@vger.kernel.org
References: <1pw4i-hM-27@gated-at.bofh.it> <1pw4i-hM-29@gated-at.bofh.it> <1pw4i-hM-31@gated-at.bofh.it> <1pw4i-hM-25@gated-at.bofh.it> <1pLmG-4E7-5@gated-at.bofh.it> <1pRLz-21o-33@gated-at.bofh.it> <1pRVi-2am-27@gated-at.bofh.it> <1pWi8-65a-11@gated-at.bofh.it> <40315225.3010104@uchicago.edu> <4031B01B.80006@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4031B01B.80006@t-online.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 17, 2004 at 07:09:31AM +0100, Harald Dunkel wrote:
> Ryan Reich wrote:
> 
> > Anyway, if you really want to correct the inconsistencies you need only
> > edit the sources for the modules in question; the names which appear in
> > /proc/modules appear to be defined in, for example,
> > drivers/usb/host/uhci-hcd.c, where the .description section of the module
> > is set. Or change the filenames, though I don't know how that will fly 
> with
> > the make process.
> >
> 
> Of course I could patch the kernel sources to remove the
> inconsistencies in the module names. But IMHO it is much
> more important to convince the kernel developers that this
> inconsistency is bad.

When 2.7 opens I will try to find out if we can rename all victims.
I can tweak kbuild to warn for modules using '-', so we in the
end can get rid of this inconsistency.

Rusty - do you see any problems with this?

	Sam
