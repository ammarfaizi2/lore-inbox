Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965222AbVKBU0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965222AbVKBU0Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 15:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965224AbVKBU0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 15:26:25 -0500
Received: from metis.extern.pengutronix.de ([83.236.181.26]:46795 "EHLO
	metis.extern.pengutronix.de") by vger.kernel.org with ESMTP
	id S965222AbVKBU0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 15:26:25 -0500
Date: Wed, 2 Nov 2005 21:26:22 +0100
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Pavel Machek <pavel@suse.cz>
Cc: vojtech@suse.cz, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: best way to handle LEDs
Message-ID: <20051102202622.GN23316@pengutronix.de>
References: <20051101234459.GA443@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20051101234459.GA443@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 12:44:59AM +0100, Pavel Machek wrote:
> Handheld machines have limited number of software-controlled status
> LEDs. Collie, for example has two of them; one is labeled "charge" and
> second is labeled "mail".
> 
> At least the "mail" led should be handled from userspace, and it would
> be nice if (at least) different speeds of blinking could be used --
> original Sharp ROM uses at least:
> 
> yellow off: 	not charging
> yellow on:	charging
> yellow fast blink: charge error
> 
> I think even slow blinking was used somewhere. I have some code from
> John Lenz (attached); it uses sysfs interface, exports led collor, and
> allows setting different frequencies.
> 
> Is that acceptable, or should some other interface be used?

IMHO reducing digital outputs to LEDs goes not far enough. All System-
on-Chip CPUs have General Purpose I/O pins today, which can act as
inputs or outputs and may be used for LEDs, matrix keyboard lines, we
even use them as shutdown lines for DC/DC converters in Linux based
power controllers for autonomous measurement systems. I think a
framework for LEDs should be based upon a low level infrastrucutre for
GPIOs. I've written such a thing some time ago, it has been discussed in 

http://marc.theaimsgroup.com/?l=linux-kernel&m=109419621428925&w=2

Unfortunately, I didn't have time to take care of that stuff yet and
port them to recent kernels :-( 

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9

