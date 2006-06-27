Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbWF0NgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbWF0NgG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 09:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbWF0NgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 09:36:06 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27614 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932270AbWF0NgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 09:36:04 -0400
Date: Tue, 27 Jun 2006 15:33:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       suspend2-devel@lists.suspend2.net
Subject: Re: Suspend2 - Request for review & inclusion in -mm
Message-ID: <20060627133321.GB3019@elf.ucw.cz>
References: <200606270147.16501.ncunningham@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606270147.16501.ncunningham@linuxmail.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'd like, at long last, to submit Suspend2 for review and inclusion in -mm.
> 
> All going well, I'll shortly be sending a number of sets of patches, which 
> together represent the whole of suspend2 as it stands at the moment. Those of 
> you who've looked at Suspend2 code before will see that there are far fewer 
> changes outside of kernel/power than there have been in the past. In some 
> cases, this is because we were early adopters of some functionality that has 
> now been merged, and in others because better, less intrusive ways have been 
> found of doing some things.
> 
> Some of the advantages of suspend2 over swsusp and uswsusp are:
> 
> - Speed (Asynchronous I/O and readahead for synchronous I/O)

uswsusp should be able to match suspend2's speed. It can do async I/O,
etc...

> - Well tested in a wide range of configurations
> - Supports multiple swap partitions and files

Doable in userspace with uswsusp.

> - Supports writing to ordinary files and raw devices.

Should be doable in userspace with uswsusp, too; I actually had raw
devices version at one point.

> - Userspace helpers for user interface and storage management.

Better put it completely in userspace :-).

> - Support for cancelling the suspend at any point while the image is being 
> written (can be disabled)

uswsusp does that... or did that at some point.

> - Can be configured and reconfigured without rebooting.

No problem for uswsusp.

> - Scripting support

What does that mean?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
