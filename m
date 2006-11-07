Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754506AbWKHKFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754506AbWKHKFR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 05:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754510AbWKHKFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 05:05:16 -0500
Received: from THUNK.ORG ([69.25.196.29]:23739 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1754506AbWKHKFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 05:05:14 -0500
Date: Tue, 7 Nov 2006 14:35:18 -0500
From: Theodore Tso <tytso@mit.edu>
To: Auke Kok <auke-jan.h.kok@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, "Robin H. Johnson" <robbat2@gentoo.org>,
       linux-kernel@vger.kernel.org
Subject: Re: e1000/ICH8LAN weirdness - no ethtool link until initially forced up
Message-ID: <20061107193518.GA26579@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Auke Kok <auke-jan.h.kok@intel.com>, Pavel Machek <pavel@ucw.cz>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	linux-kernel@vger.kernel.org
References: <20061106013153.GN15897@curie-int.orbis-terrarum.net> <20061107071449.GB21655@elf.ucw.cz> <4550AB7A.10508@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4550AB7A.10508@intel.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2006 at 07:51:22AM -0800, Auke Kok wrote:
> 
> Your application should really `ifconfig up` the device before checking for 
> link.

And for those of us with laptops, application authors should do an
"ifconfig down" the device if it doesn't find a link.  Right now
thanks to such applications on my desktop, I boot with e1000
blacklisted so I can run in low-power mode when on a laptop.

BTW, it would be nice if the e1000 driver could be more safely
unloaded when it is built as a module.  Yeah, the right answer is that
the gnome desktop is made less power hungry, and there are other
things I can do such as kill -STOP various bits of the gnome desktop
when I am running in battery mode, but it would be nice if I could
forcibly down the e1000 driver, and right not simply keeping the
module unloaded is the most reliably way of doing it in the face of
desktop applets that don't care about how much power they are sucking
down....

						- Ted
