Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030506AbWBHJIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030506AbWBHJIm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 04:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030586AbWBHJIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 04:08:41 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51645 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030506AbWBHJIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 04:08:41 -0500
Date: Wed, 8 Feb 2006 10:06:20 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Richard Purdie <rpurdie@rpsys.net>,
       Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RESEND] Add Dell laptop backlight brightness display
Message-ID: <20060208090620.GA11895@elf.ucw.cz>
References: <20060206191506.GA17395@srcf.ucam.org> <20060206191916.GB17460@srcf.ucam.org> <20060207003748.GA22510@srcf.ucam.org> <200602062237.55653.dtor_core@ameritech.net> <20060207123204.GA1423@srcf.ucam.org> <1139317605.6422.26.camel@localhost.localdomain> <20060207132334.GA2331@srcf.ucam.org> <1139319426.6422.42.camel@localhost.localdomain> <20060207135502.GA2770@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060207135502.GA2770@srcf.ucam.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
On Út 07-02-06 13:55:02, Matthew Garrett wrote:
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
> Cases rather than case, sadly. Determining whether the hardware is on AC 
> or not tends to be much more awkward than you'd think. On HPs, it seems 
> to be done by making a specific call to the embedded controller. This is 
> very model specific, whereas the brightness values aren't. It's also 
> likely to go horribly wrong if the hardware is trying to access the 
> embedded controller at the same time. Realistically, it's impossible 
> without making the driver depend on ACPI and exporting acpi_ac_get_state 
> from the ACPI layer, which would be a shame since the rest of the 
> functionality isn't ACPI dependent at all.

Depending on acpi does not seem that bad. And exporting
acpi_ac_get_state is probably good idea for other reasons, too. (Look
how powernow-k8 does it; it needs pretty reliable AC/DC info.)
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
