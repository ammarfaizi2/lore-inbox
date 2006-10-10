Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030192AbWJJQkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbWJJQkI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 12:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbWJJQkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 12:40:08 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42129 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030192AbWJJQkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 12:40:06 -0400
Date: Tue, 10 Oct 2006 18:39:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Stefan Seyfried <seife@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Jiri Kosina <jikos@jikos.cz>,
       linux-acpi@intel.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] preserve correct battery state through suspend/resume cycles
Message-ID: <20061010163951.GA31779@elf.ucw.cz>
References: <Pine.LNX.4.64.0609280446230.22576@twin.jikos.cz> <20060930114817.GA26217@suse.de> <20061008184230.GC4033@ucw.cz> <200610100052.10008.rjw@sisk.pl> <20061010121045.GQ19765@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010121045.GQ19765@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > echo "platform" > /sys/power/disk
> > > > echo "disk" > /sys/power/state
> > > 
> > > Maybe we should change the default in 2.6.20 or so?
> > 
> > Well, I think swsusp should work with "shutdown" just as well.  If it doesn't,
> > that means there are some bugs in the ACPI code which should be fixed.
> > By using "platform" as the default method we'll be hiding those bugs IMHO.
> 
> I'm not really intimately familiar with the ACPI spec, but IIRC those AML
> methods executed by pm_ops->prepare and pm_ops->finish are mandatory for
> suspending ACPI enabled machines. So using "platform" as a default
> seems

With "shutdown" we are not *suspending* machine. We are just saving
its state, and then restoring it. ACPI BIOS should not need to know.

We want both "platform" _and_ "shutdown" to work.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
