Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965104AbWBGOyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965104AbWBGOyg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 09:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbWBGOyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 09:54:36 -0500
Received: from tim.rpsys.net ([194.106.48.114]:16582 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S965104AbWBGOyf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 09:54:35 -0500
Subject: Re: [PATCH] [RESEND] Add Dell laptop backlight brightness display
From: Richard Purdie <rpurdie@rpsys.net>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20060207135502.GA2770@srcf.ucam.org>
References: <20060206191506.GA17395@srcf.ucam.org>
	 <20060206191916.GB17460@srcf.ucam.org>
	 <20060207003748.GA22510@srcf.ucam.org>
	 <200602062237.55653.dtor_core@ameritech.net>
	 <20060207123204.GA1423@srcf.ucam.org>
	 <1139317605.6422.26.camel@localhost.localdomain>
	 <20060207132334.GA2331@srcf.ucam.org>
	 <1139319426.6422.42.camel@localhost.localdomain>
	 <20060207135502.GA2770@srcf.ucam.org>
Content-Type: text/plain
Date: Tue, 07 Feb 2006 14:54:14 +0000
Message-Id: <1139324054.6422.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-07 at 13:55 +0000, Matthew Garrett wrote: 
> On Tue, Feb 07, 2006 at 01:37:06PM +0000, Richard Purdie wrote:
> > On Tue, 2006-02-07 at 13:23 +0000, Matthew Garrett wrote:
> > > Would you be open to adding generic support for displaying separate AC 
> > > and DC brightnesses? Making it driver specific leaves the potential for
> > > inconsistencies.
> > 
> > The problem is that AC or DC is not a generic property of backlights but
> > specific to your problematic hardware case. You're going to have a to
> > find a way to tell if its running on AC or not to report the right value
> > in the manner the class requires.
> 
> Realistically, it's impossible 
> without making the driver depend on ACPI and exporting acpi_ac_get_state 
> from the ACPI layer, which would be a shame since the rest of the 
> functionality isn't ACPI dependent at all.

If that's what's needed to give the correct behaviour, so be it. In an
ideal world, we'd not need the dependency but it sounds unavoidable.

You can actually have a soft dependency where it could use the DC value
unless ACPI is present in which case it would be more intelligent. The
corgi_bl driver does this for the backlight limiting on low power. 

Richard

