Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbWGEPzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWGEPzw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 11:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbWGEPzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 11:55:52 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:35999 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964800AbWGEPzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 11:55:51 -0400
Date: Wed, 5 Jul 2006 10:55:37 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Jeff Garzik <jeff@garzik.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] PCI: Move various PCI IDs to header file
In-Reply-To: <449B440B.7010407@garzik.org>
Message-ID: <20060705104039.E93671@pkunk.americas.sgi.com>
References: <200606222300.k5MN0uPW000741@hera.kernel.org> <449B440B.7010407@garzik.org>
Organization: Silicon Graphics, Inc.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

I apologize for the incredibly late reply.  Your objection of course
came up mere hours after I left on a vacation of nearly two weeks.

I also apologize for failing to CC linux-ide.  I did, however,
originally CC the author of the Vitesse VSC driver (Jeremy Higdon).

The patch was submitted precisely because the PCI device ID was no
longer going to be single-use.  In fact, shortly after the message
you posted below, Andrew posted the following (which has been queued
up for a month or so):

	[patch 187/200] SGI IOC4: Detect IO card variant

In short, due to the unusual card design of the SGI IO10 card, and
the need to differentiate it from the SGI PCI-RT card, I was left
with no reasonable option other than to look for the existence of
the Vitesse device at a known PCI bus location.  As such I needed
to re-use the PCI ID of the Vitesse part, thereby making it dual-use
and qualifying it for assignment of a PCI_DEVICE_ID_xxx constant.

I did perhaps overstep by also creating a PCI_DEVICE_ID_xxx constant
for the purportedly identical Intel part.  Am I allowed a third apology
within a single email?

Brent

On Thu, 22 Jun 2006, Jeff Garzik wrote:

> WTF?  This is a REGRESSION from the repeatedly expressed desire -- clear
> throughout libata -- that single-use PCI device IDs should not ever receive
> PCI_DEVICE_ID_xxx constants.
> 
> I'm going to queue up a revert patch for this silliness.
> 
> Next time, please let the relevant maintainer(s) know when you are touching
> their driver, so they have a chance to filter out the crap.
> 
> This was -never- sent to me or linux-ide, or otherwise brought to the
> attention of the maintainers.

-- 
Brent Casavant                          All music is folk music.  I ain't
bcasavan@sgi.com                        never heard a horse sing a song.
Silicon Graphics, Inc.                    -- Louis Armstrong
