Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWAPDqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWAPDqa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 22:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWAPDqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 22:46:30 -0500
Received: from mx1.rowland.org ([192.131.102.7]:531 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S932201AbWAPDq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 22:46:29 -0500
Date: Sun, 15 Jan 2006 22:46:28 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Reuben Farrelly <reuben-lkml@reub.net>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
       <linux-usb-devel@lists.sourceforge.net>,
       Neil Brown <neilb@cse.unsw.edu.au>, <linux-acpi@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: 2.6.15-mm3 [USB lost interrupt bug]
In-Reply-To: <43CB12EA.3040309@reub.net>
Message-ID: <Pine.LNX.4.44L0.0601152243330.1929-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2006, Reuben Farrelly wrote:

> > From the information presented here, it looks like -mm1 correctly routes
> > the 1d.1 controller to IRQ 193 and the 1d.3 controller to IRQ 169, whereas
> > -mm3 incorrectly routes the 1d.3 controller to IRQ 193.  That would make 
> > it an ACPI problem.
> 
> Is this likely to be the same or similar issue to the IRQ 0 problem I see quite 
> frequently on the SATA ports on later -mm releases?
> (see http://www.ussg.iu.edu/hypermail/linux/kernel/0601.1/1851.html)

I doubt they are at all related.  In the USB problem the resource is there 
but ACPI is routing it wrongly.  In the SATA problem the resource isn't 
there to begin with.

But then I know almost nothing about ACPI, so I could be wrong...

Alan Stern

