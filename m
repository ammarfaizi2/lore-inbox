Return-Path: <linux-kernel-owner+w=401wt.eu-S1753233AbWLQXfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233AbWLQXfL (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 18:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753232AbWLQXfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 18:35:11 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:43870 "EHLO
	vms040pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233AbWLQXfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 18:35:09 -0500
Date: Sun, 17 Dec 2006 18:34:59 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: ieee1394 in 2.6.20-rc1 (was Re: Linux 2.6.20-rc1)
In-reply-to: <4585A6C3.6010107@s5r6.in-berlin.de>
To: linux-kernel@vger.kernel.org
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Linus Torvalds <torvalds@osdl.org>,
       linux1394-devel@lists.sourceforge.net
Message-id: <200612171834.59624.gene.heskett@verizon.net>
Organization: Not detectable
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org>
 <200612171404.56278.gene.heskett@verizon.net>
 <4585A6C3.6010107@s5r6.in-berlin.de>
User-Agent: KMail/1.9.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 17 December 2006 15:21, Stefan Richter wrote:
[...]
>What if you prevent dv1394 from ever being loaded, or don't build it in
>the first place? CONFIG_IEEE1394_DV1394=n

How about '# CONFIG_IEEE1394_DV1394 is not set'?

Hand edited the .config and fired off my makeit script, which does it all 
& rebooted.

[root@coyote ~]# lsmod|grep 1394
raw1394                32264  0
ohci1394               39088  0
ieee1394              305624  2 raw1394,ohci1394

The camera has been turned back off, but yes, it works absolutely normally 
now.  With no dv1394 in memory!

Then with the camera on and kino controlling it:
[root@coyote ~]# lsmod|grep 1394
raw1394                32264  4
ohci1394               39088  0
ieee1394              305624  2 raw1394,ohci1394

So we still don't appear to have any use of/for ohci1394.  What the heck 
is it supposed to be doing?

Now, do I need dv1394 to do the export if I were to want to re-write the 
edited video back to the tape in the camera?  This is something I believe 
I'm supposed to be able to do, but never have yet as I consider the tape 
a capture only medium due to incompatibilities with the vcr Joe Sixpack 
has.  Just about everyone has a dvd player these days, so that is what I 
export to.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
