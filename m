Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWGGJcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWGGJcN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 05:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbWGGJcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 05:32:13 -0400
Received: from styx.suse.cz ([82.119.242.94]:61846 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932084AbWGGJcM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 05:32:12 -0400
Date: Fri, 7 Jul 2006 11:31:38 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Henrique de Moraes Holschuh <hmh@debian.org>
Cc: Robert Hancock <hancockr@shaw.ca>, Pavel Machek <pavel@suse.cz>,
       lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net, Stelian Pop <stelian@popies.net>,
       Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: Re: Generic interface for accelerometers (AMS, HDAPS, ...)
Message-ID: <20060707093138.GD11026@suse.cz>
References: <fa.GOQkHC8inXir2wbg4bZayOWXzAY@ifi.uio.no> <fa.qLWuLxQd7Mhcnixy/TLVs/nPwig@ifi.uio.no> <44AC5261.9050708@shaw.ca> <20060706061930.GA6033@suse.cz> <20060707024603.GC22666@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060707024603.GC22666@khazad-dum.debian.net>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2006 at 11:46:04PM -0300, Henrique de Moraes Holschuh wrote:
> On Thu, 06 Jul 2006, Vojtech Pavlik wrote:
> > > >We are investigating the ACPI global lock as a way to at least get the
> > > >SMBIOS to stay away from the EC while we talk to it, but we don't know if
> > > >the entire SMBIOS firmware respects that lock.
> > > 
> > > It had better, that is exactly what the ACPI Global Lock is supposed to 
> > > prevent (concurrent access to non-sharable resources between the OS and 
> > > SMI code). The ACPI DSDT contains information on whether or not the 
> > > machine requires the Global Lock in order to access the EC or whether it 
> > > is safe to access without locking.
> >  
> > Isn't that vaild only if you actully use ACPI to access the EC? (AFAIK
> > the HDAPS driver does direct port access.)
> 
> It better be valid for any OS-side access to the EC, otherwise the ACPI
> global lock would be utterly useless.  The system vendor would have done its
> own "global-lock-like" functionality without the need for an ACPI global
> lock specification.

That's what I fear does happen on many systems.

> What is not clear to me is whether an ACPI DSDT method is on the "OS side"
> or on the "SMM side" of the ACPI global lock.

No idea, sorry.

-- 
Vojtech Pavlik
Director SuSE Labs
