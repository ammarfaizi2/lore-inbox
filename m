Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272858AbTG3M2u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 08:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272857AbTG3M2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 08:28:49 -0400
Received: from duck.doc.ic.ac.uk ([146.169.1.46]:35600 "EHLO duck.doc.ic.ac.uk")
	by vger.kernel.org with ESMTP id S272869AbTG3M1u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 08:27:50 -0400
Date: Wed, 30 Jul 2003 13:27:49 +0100
From: Philip Graham Willoughby <pgw99@doc.ic.ac.uk>
To: Ghozlane Toumi <gtoumi@laposte.net>
Cc: Jamey Hicks <jamey.hicks@hp.com>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH : LEDs - possibly the most pointless kernel subsystemever
Message-ID: <20030730122749.GA31982@bodmin.doc.ic.ac.uk>
References: <20030729151701.GA6795@bodmin.doc.ic.ac.uk> <20030729180005.GD2601@openzaurus.ucw.cz> <1059565549.27394.9.camel@vimes.crl.hpl.hp.com> <001101c35693$8e97cc40$0a00a8c0@toumi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001101c35693$8e97cc40$0a00a8c0@toumi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-07-30 14:06:43 +0000, Ghozlane Toumi wrote:
> > I would have thought that leds are output?  Why would output devices be
> > integrated into the input subsystem?
> 
> Perhaps because the input subsystem could/should be renamed to event
> subsytem ?

The LED devices I'm using are nothing like any of the devices in the
input subsystem at all -- they don't generate events _ever_ for
instance.  /dev/input/event## for a pure LED device would be rather
boring.

IMO it's cleaner to have a LED subsystem and proxy drivers to expose
LEDs provided by other subsystems to the generic interface, rather than
trying to ram everything onto the input subsystem regardless of how well
it fits.

Of course, other opinions may (will) differ ;-).

If you did want to get the LED change events from the LED subsystem
through the input layer, you could add a hook into led_set_real in
leds.c, but since all changes are software triggered I don't really see
the value in that.

Regards,

Philip Willoughby

Systems Programmer, Department of Computing, Imperial College, London, UK
-- 
echo bzidd@nfo.ho.co.se | tr "bizndfohces" "pwgd9ociaku"
Why reinvent the wheel?                 Because we can make it rounder...
