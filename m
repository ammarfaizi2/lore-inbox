Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264545AbUAFPhP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 10:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264546AbUAFPhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 10:37:15 -0500
Received: from ida.rowland.org ([192.131.102.52]:3588 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S264545AbUAFPhK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 10:37:10 -0500
Date: Tue, 6 Jan 2004 10:37:10 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
cc: Javier Marcet <javier@marcet.info>, <linux-kernel@vger.kernel.org>,
       <usb-storage@one-eyed-alien.net>,
       <linux-usb-users@lists.sourceforge.net>
Subject: Re: [usb-storage] Re: usb-storage && iRIVER flash player problem
In-Reply-To: <20040106065655.GA10031@one-eyed-alien.net>
Message-ID: <Pine.LNX.4.44L0.0401061035420.770-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jan 2004, Matthew Dharm wrote:

> On Mon, Jan 05, 2004 at 09:03:33PM +0100, Javier Marcet wrote:
> > * Matthew Dharm <mdharm-kernel@one-eyed-alien.net> [040105 20:02]:
> > 
> > >It looks like your device is choking over the ALLOW_MEDIUM_REMOVAL command
> > >-- I've never seen a device broken in this particular way before.
> > 
> > >If you edit drivers/scsi/sd.c to remove the sending of that command (it's
> > >normally used to lock the media-eject button on devices that support it),
> > >we should be able to test this theory.  If this is the case, then we may
> > >need to modify the SCSI layer to only send that command if the RMB bit is
> > >set.

> Hrm... what's the easiest way for Javier to figure out if his device sets
> the RMB or not?
> 
> I feel another SCSI enhancement coming on....

It's not so simple, unfortunately.  In 2.6, sd.c already does check that 
sdev->removable is set before issuing PREVENT ALLOW MEDIUM REMOVAL.

Alan Stern

