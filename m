Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbTJ1ACL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 19:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263776AbTJ1ACL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 19:02:11 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:45954 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263775AbTJ1ACH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 19:02:07 -0500
Date: Mon, 27 Oct 2003 16:01:13 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Pedro Larroy <piotr@member.fsf.org>,
       Matthew Dharm <mdharm-usb@one-eyed-alien.net>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: aborts in usb-storage in branch 2.6
Message-ID: <20031027160113.A2582@beaverton.ibm.com>
References: <20031023165953.GA1410@81.38.200.176> <Pine.LNX.4.44L0.0310241712140.2594-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44L0.0310241712140.2594-100000@ida.rowland.org>; from stern@rowland.harvard.edu on Fri, Oct 24, 2003 at 05:15:13PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 24, 2003 at 05:15:13PM -0400, Alan Stern wrote:
> On Thu, 23 Oct 2003, Pedro Larroy wrote:

> > abort.log -> 2.6.0test8
> > devices -> 2.6.0test8
> > kernel.log -> 2.6.0testx  where x < 8
> > 
> > In abort.log, is the paste of the log with kernel 2.6.0test8 in kern.log
> > there is a log from 2.6.0test4 or 2.6.0test4-mm
> > 
> > On previous 2.6.0testx kernels the bug appeared to trigger when ACPI debug
> > statements were printed, notice there are aborts after ACPI printks.
> > 
> > On 2.6.0test8 it seems to be triggered when doing concurrent access to the
> > filesystem.
> > 
> > I would like to help in anyway I can, but ACPI and USB is far beyond my
> > kernel knowledge, so I'm not currently able to fix the bugs myself.

> I looked at your logs, but I can't add much to what you already know.  
> This certainly does appear to be some sort of interrupt sharing/routing
> problem -- the logs don't indicate anything specific to USB.  However
> there's no easy way to tell what the source of that problem is.

The logs look like a SCSI timeout - a 30 second gap, followed by abort,
test unit ready, and a resend of the timed out write. That does not help
much. It could certainly be a lost interrupt.

I did not see any timeout/aborts happening (immediately) after the acpi
messages.

> Maybe someone who knows more about ACPI and interrupt handling can help.

I don't know ACPI, but I thought interrupt problems it might cause
happened more consistently.

-- Patrick Mansfield
