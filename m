Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262829AbVA2AL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262829AbVA2AL4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 19:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262828AbVA2ALz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 19:11:55 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2715 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262829AbVA2ALJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 19:11:09 -0500
Date: Sat, 29 Jan 2005 00:11:05 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Dmitry Torokhov <dtor_core@ameritech.net>,
       g@parcelfarce.linux.theplanet.co.uk
Cc: Adam Belay <abelay@novell.com>, greg@kroah.com, rml@novell.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] add driver matching priorities
Message-ID: <20050129001105.GQ8859@parcelfarce.linux.theplanet.co.uk>
References: <1106951404.29709.20.camel@localhost.localdomain> <200501281823.27132.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200501281823.27132.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 06:23:26PM -0500, Dmitry Torokhov wrote:
> On Friday 28 January 2005 17:30, Adam Belay wrote:
> > Of course this patch is not going to be effective alone.  We also need
> > to change the init order.  If a driver is registered early but isn't the
> > best available, it will be bound to the device prematurely.  This would
> > be a problem for carbus (yenta) bridges.
> > 
> > I think we may have to load all in kernel drivers first, and then begin
> > matching them to hardware.  Do you agree?  If so, I'd be happy to make a
> > patch for that too.
> > 
> 
> I disagree. The driver core should automatically unbind generic driver
> from a device when native driver gets loaded. I think the only change is
> that we can no longer skip devices that are bound to a driver and match
> them all over again when a new driver is loaded.  

And what happens if we've already got the object busy?
