Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261730AbVCQBVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbVCQBVX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 20:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262951AbVCQBVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 20:21:21 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:24312 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S262958AbVCQBPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 20:15:42 -0500
Date: Wed, 16 Mar 2005 20:15:37 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: tvtime audio vs pcHDTV-3000 card and pvHDTV-1.6 software
To: linux-kernel@vger.kernel.org,
       Linux and Kernel Video <video4linux-list@redhat.com>
Reply-to: gene.heskett@verizon.net
Message-id: <200503162015.37331.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I've spent a goodly part of the last 3 hours rebooting, to find out 
where this audio control function died, and I think now I can point 
an accusatory finger at the 2.6.11.2 patch with some degree of 
certainty.

The scenario goes like this:

reboot to 2.6.11-rc5, everything works flawlessly except the 1394 
stuff, that kernel didn't have it built in yet.

reboot to 2.6.11+bk-ieee1394.patch  everything works flawlessly

reboot to 2.6.11.1+bk-ieee1394.patch everything works flawlessly

reboot to 2.6.11.2+bk-ieee1394.patch tvtime has no volume control, and 
the sound gets very very tinny about 1 second after it starts

This scenario continues up to and includeing 2.6.11.4.

So now my next question is, how to I clean up those src trees so that 
a diff actually outputs only the src code differences, thereby 
allowing a simple diff -urN (or whatever is the recommended command 
line to do a recursive diff on the whole maryann) to disclose the 
real diffs.  In other words, is a simple 'make clean' sufficient?

I got the impression from a comment that was made, that quite a body 
of work was actually done, in the i2c area, that somehow does not 
show in the changelog, nor in that simple little 10 line patch that 
was 2.6.11.2.  And how that little patch could be responsible for 
breaking this boggles what tiny little miniscule piece of a mind I 
have left at this point.

If thats the case, then how did it get into my src code tree since the 
exact same 2.6.11.tar.gz was used as the base for applying each of 
the incrementals to each of the src trees I now have sitting 
in /usr/src?  Good question that...

Unforch, the 2.6.11 plain tree has not, in this case been built yet as 
it got accidently nuked by a missfire of my 'buildit26' script, which 
normally moves a base version tree out of the way before it unpacks a 
fresh copy, and then renames that tree to be the current version and 
then restores the base tree to its original name.

Thats not the one I want to use as the 'gold standard' anyway. 
2.6.11.1 works, and 2.6.11.2 doesn't.  So at this point, 2.6.11.1 is 
the 'gold standard'.

But, both the 2.6.11.1 and the 2.6.11.2 trees are as built, and the
diff I got was far larger than forgetting to apply the 
bk-ieee1394.patch to one of them would account for.  Many tens of 
kilobytes in fact.

Please throw me a bone here folks.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
