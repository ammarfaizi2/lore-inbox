Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWGDIAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWGDIAI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 04:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWGDIAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 04:00:08 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5039 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750731AbWGDIAG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 04:00:06 -0400
Date: Tue, 4 Jul 2006 09:59:50 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Henrique de Moraes Holschuh <hmh@debian.org>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net, Stelian Pop <stelian@popies.net>,
       Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: Re: Generic interface for accelerometers (AMS, HDAPS, ...)
Message-ID: <20060704075950.GA13073@elf.ucw.cz>
References: <20060703124823.GA18821@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060703124823.GA18821@khazad-dum.debian.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2006-07-03 09:48:23, Henrique de Moraes Holschuh wrote:
> We have now (or we are about to have, anyway) two drivers that export
> accelerometer data: IBM's HDAPS, and Apple's AMS.  More accelerometer
> drivers could be coming in the future.
> 
> Both drivers export one common set of data (accelerometer output), and some
> extra information that is not related to acellerometers.  Both have at least
> two functionality goals in common: to export accelerometer data to
> userspace, and also to allow somehow for HD head parking when the
> accelerometer detects a potentially incoming impact.
> 
> User­space utilities that interface to accelerometers like hdapsd and
> smackpad could benefit from a common interface, so that they work with
> HDAPS, AMS, and any other future accelerometer drivers.
> 
> If any kernel-space functionality needed by HDAPS and AMS is also shared, we
> would have benefits there too.  Some examples I can think of are: generic HD
> queue-freeze and HD head parking, and a generic acellerometer-driven
> joystick event interface.  This would also enable generic userspace
> notifiers that the HD heads have been parked, etc.
> 
> I am posting this message as a head's up for the two projects (HDAPS, AMS)
> to make sure that they are actively aware of each other.  I do so in hope
> that we can work in a joint, generic interface and port both drivers to this
> new interface in the near future, and also that we can make as much
> functionality shared between the two drivers as possible.

Just use input infrastructure and be done with that? You can do
parking from userspace.

Only piece of puzzle missing is marking that input device as "this
accelerometer actually watches the whole device".
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
