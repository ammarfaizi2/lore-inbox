Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268442AbTGLUGi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 16:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268449AbTGLUGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 16:06:38 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:38830 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S268442AbTGLUGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 16:06:36 -0400
Date: Sat, 12 Jul 2003 21:23:52 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de, akpm@osdl.org
Subject: Re: 2.5 'what to expect'
Message-ID: <20030712202352.GA7741@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Meelis Roos <mroos@linux.ee>, linux-kernel@vger.kernel.org,
	axboe@suse.de, akpm@osdl.org
References: <20030711140219.GB16433@suse.de> <E19bK8w-0004Ij-00@roos.tartu-labor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19bK8w-0004Ij-00@roos.tartu-labor>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 12, 2003 at 04:10:26PM +0300, Meelis Roos wrote:
 > elvtune is mentioned here...
 > 
 > DJ> - Several different IO elevators are available to match different types
 > DJ>   of workload.  You can select which one to use with elvtune.
 > but deprecated here:
 > 
 > DJ> Deprecated.
 > DJ> ~~~~~~~~~~~
 > DJ> - usbdevfs will be going away in 2.7. The same filesystem can
 > DJ>   be mounted as 'usbfs' in recent 2.4 kernels, and in 2.5.52
 > DJ>   and above, which is what the filesystem will furthermore be
 > DJ>   known as.
 > DJ> - elvtune is deprecated (as are the ioctl's it used).
 > DJ>   Instead, the io scheduler tunables are exported in sysfs (see below)
 > DJ>   in the /sys/block/<device>/iosched directory.
 > DJ>   Jens wrote a document explaining the tunables of the new scheduler at
 > DJ>   http://www.lib.uaa.alaska.edu/linux-kernel/archive/2002-Week-44/att-deadline-iosched.txt

Something seems amiss. The deprecated elvtune interface is the old -r/-w/-b command line.
I was lead to believe a new elvtune appeared which supports an option
for changing the elevator under 2.5, however a quick google doesn't turn
up any such patched elvtune, so I'm somewhat puzzled.
 
 > Maybe just suggest the sysfs interface at once and not mention elvtune?

Changing the elevator type per device via sysfs does seem to make sense,
however /sys/block/<devicename>/queue/iosched/ doesn't yield anything
that would suggest this is possible (yet).  I think Jens has patches for this?

Right now, afaics, the only way to change elevator is on a global (all
device) basis, booting with elevator=deadline or the like, so it looks
like the quote from post-halloween-2.5.txt has jumped the gun a little
and is discussing an as-yet unmerged feature. Jens ?

		Dave

