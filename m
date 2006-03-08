Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbWCHUvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbWCHUvS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 15:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWCHUvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 15:51:17 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:38589 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932469AbWCHUvR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 15:51:17 -0500
Date: Wed, 8 Mar 2006 15:51:16 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: david-b@pacbell.net, <linux-usb-devel@lists.sourceforge.net>,
       <greg@kroah.com>, <torvalds@osdl.org>, <mingo@elte.hu>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: Fw: Re: oops in choose_configuration()
In-Reply-To: <20060308121401.7926bf02.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44L0.0603081539300.5360-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Mar 2006, Andrew Morton wrote:

> Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > Andrew, if you tell us what's in your /proc/bus/usb/devices we'll see
> >  whether that was the real problem.
> 
> Below.

Unforunately, the data shows that all your devices' configurations do
indeed have at least one interface.  (Unless your ALPS or Microsoft HID
device just happens to report differently once every few thousand
times...)  So scratch that theory.  Besides, it doesn't explain the
crashes you got that were not connected to usb_choose_configuration.

> >  In any case, a patch follows.
> 
> ooh, I like patches.

We should keep the patch.  After all, some weird device might need it 
eventually.

> This crash manifests in several ways.  Pretty much any debugging patches
> seem to make it hide.

Aren't those your favorite kind of bugs?  Maybe we should just add a 
permanent debugging patch, with the expectation that it will never trigger 
and therefore will solve the bug.  :-)

What about those scheduler changes you found through the bisection search?  
Any word on that?

Alan Stern

