Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270806AbTG0Oml (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 10:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270807AbTG0Oml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 10:42:41 -0400
Received: from netrider.rowland.org ([192.131.102.5]:27918 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S270806AbTG0Omj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 10:42:39 -0400
Date: Sun, 27 Jul 2003 10:57:53 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Pavel Machek <pavel@ucw.cz>
cc: David Brownell <david-b@pacbell.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Dominik Brugger <ml.dominik83@gmx.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: OHCI problems with suspend/resume
In-Reply-To: <20030726210123.GD266@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44L0.0307271056110.24895-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jul 2003, Pavel Machek wrote:

> Hi!
> 
> > >>I'm not sure how the design is intended to work, but either way something 
> > >>needs to be fixed.
> > 
> > Yes, it seems like all the HCDs (and the hub driver) need attention.
> 
> Why the hub driver?
> 
> For basic functionality, you simply power it down (doing virtual
> unplug), and power it back up on resume (doing virtual plug of all
> devices). That should work reasonably for everything but mass-storage.

Almost correct.  It's also necessary to stop/reinitialize a periodic
status request.

None of this functionality has been implemented yet.

Alan Stern

