Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265910AbUGMVDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265910AbUGMVDW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 17:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265913AbUGMVDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 17:03:22 -0400
Received: from zeus.kernel.org ([204.152.189.113]:14504 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S265910AbUGMVDR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 17:03:17 -0400
Date: Tue, 13 Jul 2004 22:01:23 +0200
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: suspend/resume success and failure report and questions
Message-ID: <20040713200123.GA13091@gamma.logic.tuwien.ac.at>
References: <20040710083027.GB27827@gamma.logic.tuwien.ac.at> <20040713193640.GG3654@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040713193640.GG3654@openzaurus.ucw.cz>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel!

On Die, 13 Jul 2004, Pavel Machek wrote:
> > 	Only thing I am missing is some way of post-resume script.
> 
> echo 4 > /proc/acpi/sleep; post_resume_script

Thanks for this, I realized it after playing around a bit.

> > - partial Suspend2Ram via mem > /sys/power/state
> 
> See video.txt. Perhaps usb & radeon need some more
> suspend/resume support?

Ok, I have to get this patched video driver to work, means recompiling
debian/sid package with this fix.

For usb, no idea, but I can live with /etc/init.d/hotplug stop ; sleep ;
... start.

> > - network drivers (b44)
> 
> Should work ok.

They do, meanwhile I have tested them.

And orinoco from cvs also works.

Thanks a lot and best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
TYNE and WEAR (nouns)
The 'Tyne' is the small priceless or vital object accidentally dropped
on the floor (e.g. diamond tie clip, contact lens) and the 'wear' is
the large immovable object (e.g. Welsh dresser, car-crusher) that it
shelters under.
			--- Douglas Adams, The Meaning of Liff
