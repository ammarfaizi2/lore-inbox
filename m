Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbWGFGUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbWGFGUD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 02:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030195AbWGFGUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 02:20:01 -0400
Received: from styx.suse.cz ([82.119.242.94]:54987 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1030186AbWGFGUB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 02:20:01 -0400
Date: Thu, 6 Jul 2006 08:19:30 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Robert Hancock <hancockr@shaw.ca>
Cc: Henrique de Moraes Holschuh <hmh@debian.org>, Pavel Machek <pavel@suse.cz>,
       lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net, Stelian Pop <stelian@popies.net>,
       Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: Re: Generic interface for accelerometers (AMS, HDAPS, ...)
Message-ID: <20060706061930.GA6033@suse.cz>
References: <fa.GOQkHC8inXir2wbg4bZayOWXzAY@ifi.uio.no> <fa.qLWuLxQd7Mhcnixy/TLVs/nPwig@ifi.uio.no> <44AC5261.9050708@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44AC5261.9050708@shaw.ca>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2006 at 05:59:29PM -0600, Robert Hancock wrote:
> Henrique de Moraes Holschuh wrote:
> >HDAPS talks to the embedded controller using IO over the LPC bus, and not 
> >to
> >the accelerometer chip or to a simple A/D i2c chip which is used excusively
> >for accelerometer access.  The EC interface for HDAPS data retrieval is
> >not friendly to any errors, and hardlocks the machine somehow if any
> >firmware bugs hit or if we violate any of the rules (that are not written
> >anywhere) about how to access the EC without geting the SMBIOS unhappy.
> >
> >So, turning off HDAPS polling while it is not necessary really looks like a
> >good idea overall.
> >
> >We are investigating the ACPI global lock as a way to at least get the
> >SMBIOS to stay away from the EC while we talk to it, but we don't know if
> >the entire SMBIOS firmware respects that lock.
> 
> It had better, that is exactly what the ACPI Global Lock is supposed to 
> prevent (concurrent access to non-sharable resources between the OS and 
> SMI code). The ACPI DSDT contains information on whether or not the 
> machine requires the Global Lock in order to access the EC or whether it 
> is safe to access without locking.
 
Isn't that vaild only if you actully use ACPI to access the EC? (AFAIK
the HDAPS driver does direct port access.)

-- 
Vojtech Pavlik
Director SuSE Labs
