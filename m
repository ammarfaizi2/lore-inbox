Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266554AbUBLT24 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 14:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266563AbUBLT2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 14:28:55 -0500
Received: from web21204.mail.yahoo.com ([216.136.131.77]:63674 "HELO
	web21204.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266554AbUBLT2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 14:28:50 -0500
Message-ID: <20040212192848.29083.qmail@web21204.mail.yahoo.com>
Date: Thu, 12 Feb 2004 11:28:48 -0800 (PST)
From: Konstantin Kudin <konstantin_kudin@yahoo.com>
Subject: Strange boot with multiple identical disks
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi everybody,

 Here is the issue. A redhat 9 linux system had 2
drives, /hda and /hdb. Then /hda started developing
bad clusters {UncorrectableError}, so I got an
identical warranty replacement drive.

 Then I hooked up the new drive as /hdc, and did a
sector by sector copy {dd if=/dev/hda of=/dev/hdc
conv=noerror,sync} Overall, I got ~2k of bad 512B
sectors.

 Then I swaped the fresh one to /hda, and put aside
the failing one. I booted, did fsck on all partitions
and also raids, and things came up fine. So far so
good.

 Now I am trying to add the failing one as /hdc, and
boot. Linux starts to display all kinds of weird
messages, and thinks that / partition was shut down
uncleanly. I just hit "reset". Then I disable /hdc via
the boot option hdc=noprobe, and things boot fine. If
I try to disable raid via raid=noautodetect, the bunch
of errors still appears and the boot is no go. Done
this several times, without /hdc things are fine, with
- all kinds of issues.

 What is the problem for linux to boot on /hda when
/hdc is detected and has almost identical setup? 
Where does it read all the garbage that starts to
screw up the boot process when /hdc is detected? I'd
like to hook up /hdc to wipe out the data there. The
drive is huge, so I'd rather wipe it out while working
then under other circumstances.
 
 Thanks!

 Konstantin

__________________________________
Do you Yahoo!?
Yahoo! Finance: Get your refund fast by filing online.
http://taxes.yahoo.com/filing.html
