Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754523AbWKMMSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754523AbWKMMSV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 07:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754525AbWKMMSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 07:18:21 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42372 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1754523AbWKMMSU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 07:18:20 -0500
Date: Mon, 13 Nov 2006 13:18:02 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <greg@kroah.com>
Cc: Michael Holzheu <HOLZHEU@de.ibm.com>,
       Randy Dunlap <randy.dunlap@oracle.com>,
       Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       mschwid2@de.ibm.com
Subject: Re: How to document dimension units for virtual files?
Message-ID: <20061113121802.GC31613@elf.ucw.cz>
References: <20061108090454.dba20e01.randy.dunlap@oracle.com> <OF2A3BB933.427A044B-ON41257220.006509CA-41257220.00656F8A@de.ibm.com> <20061110065336.GA13646@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061110065336.GA13646@kroah.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > If you want to export data to userspace via a virtual filesystem
> > like sysfs, the following rules are recommended:
> 
> Um, does this mean you expect us to change all of the currently existing
> sysfs file names?  And people get mad at me when I just move sysfs
> symlinks around...
> 
> Look at the hwmon drivers, and the documentation in
> Documentation/hwmon/sysfs-interface for a description of how we have
> been documenting this already.
> 
> In short, I don't really think we need to encode the units in the file
> name, somehow we have done pretty well without it so far :)

Well, problem is that some notebooks have battery capacity in mAh, and
some in mWh, and you can't convert between those.

We could do something like 

battery_stored_energy and battery_stored_current
                 (mWh)                      (mAh)

...but it looks ugly, and battery_capacity:mAh does not sound that bad
for a new interface.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
