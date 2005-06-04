Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbVFDQcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVFDQcW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 12:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVFDQcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 12:32:22 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:33166 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261364AbVFDQcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 12:32:16 -0400
Date: Sat, 4 Jun 2005 18:31:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6.12 -- long bug list
Message-ID: <20050604163157.GA1849@elf.ucw.cz>
References: <20050604154254.GD756@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050604154254.GD756@openzaurus.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> My things-to-worry-about folder still has 244 entries.  Nobody seems to
> care much.  Poor me.

:-)

> Subject: [Bugme-new] [Bug 4340] New: ohci_1394 module breaks S3 suspend

Firewire suspend/resume is not supported, nothing new...

> Subject: [Bugme-new] [Bug 4371] New: Battery doesn't work after suspend

Duplicate of 4340.

[Bugzilla is piece of ****. This is listed as severity=high, which is
not realistics AFAICT. Also to mark it as duplicate, I need to change
it to ASSIGNED, first. Ugly].

> Subject: [Bugme-new] [Bug 4390] New: power saving doesn't work on

Its standby that does not work... I could fix the subject if stupid
bugzilla let me. Oops.

> Subject: Re: 2.6.12-rc1-mm1: resume regression [update] (was:
> Subject: Re: 2.6.12-rc1-mm1: resume regression [update] (was: Re:
> Subject: Re: 2.6.12-rc1-mm1: resume regression [update] (was: Re: 2.6.12-rc1-mm1: Kernel BUG at pci:389)
> Subject: Re: 2.6.12-rc1-mm1: resume regression [update] (was: Re:2.6.12-rc1-mm1: Kernel BUG at pci:389)
> Subject: Re: 2.6.12-rc1-mm3: box hangs solid on resume from disk while resuming device drivers
> Subject: Re: [ACPI] Re: 2.6.12-rc1-mm4 and suspend2ram (and synaptics)
> Subject: Re: swsusp not working for me on a PREEMPT 2.6.12-rc1 and 2.6.12-rc1-mm3 kernel

-rc1 is quite old, i think these can be safely ignored now...

> Subject: Re: [linux-pm] potential pitfall? changing configuration while PC in hibernate (fwd)
> Subject: Re: [linux-usb-devel] Re: [linux-pm] potential pitfall? changing configuration while PC in hibernate (fwd)

Ignore this. Changing config is *not* okay in 2.6.12 swsusp. Its even
documented:

 *
 * If you change kernel command line between suspend and resume...
 *                              ...prepare for nasty fsck or worse.
 *
 * If you change your hardware while system is suspended...
 *                              ...well, it was not good idea.
 *

> Subject: Re: [PATCH 6/6]suspend/resume SMP support

I do not think we want to support SMP suspend/resume in 2.6.12... It
should work in -mmX, but is still too much in flux.

								Pavel
