Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263118AbTJPTQr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 15:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263119AbTJPTQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 15:16:46 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:29701 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263118AbTJPTQo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 15:16:44 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: usb-storage kills lilo (2.6-test[67])
Date: 16 Oct 2003 19:06:50 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bmmq8a$hug$1@gatekeeper.tmr.com>
References: <20031012051107.GA1881@defiant>
X-Trace: gatekeeper.tmr.com 1066331210 18384 192.168.12.62 (16 Oct 2003 19:06:50 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031012051107.GA1881@defiant>,
Norbert Kiesel  <nkiesel@tbdnetworks.com> wrote:
| (sorry for the flashy subject, but I could not come up with another one
| :-)
| 
| Hi, I got problems with usb-storage and linux-2.6-test[67]. AFAICS,
| test5 works fine (still have to retest to make sure).
| 
| Problem is that inserting my USB flash memory disk makes /dev/sda (and
| /dev/sda1) appear in /proc/partitions, but removing it does not remove
| the entries from /proc/partitions.  lilo is reading /proc/partitions
| (verified trough strace) and dies because /dev/sda is gone.
| 
| Possibly related to that is the next time I insert the flash disk, is
| shows up as /dev/sdb1 (and adds this to /proc/partiotions, too). 

I have seen similar behaviour with flash readers. I have CF and memstick
readers, and after a photo session I'm likely to have a bunch of each to
unload. If I do the CF first, the device is sda. Even changing media,
still sda. But when I unplug and connect the memstick reader, that
becomes sdb, and sda is shown as missing in action.

I didn't report it because I lack time to characterize it properly and I
can live with it. But since you report the problem, I'll throw this info
out in case it helps someone else understand exactly what's happening.

I *believe* I first saw it in test4, I haven't been running 2.6 kernels
lately on that machine, so I can't say if it's still an issue.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
