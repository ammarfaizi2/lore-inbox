Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264368AbTLBUS6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 15:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264366AbTLBUQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 15:16:59 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:43464
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S264343AbTLBUNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 15:13:39 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: linux-kernel@vger.kernel.org
Subject: Software suspend under -test10.
Date: Tue, 2 Dec 2003 14:13:14 -0600
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312021413.15131.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using the /sys/power/state = disk method, here's what's different:

During suspend, the power to the screen gets shut off fairly early on so I 
can't see what suspend is doing.  It does continue and suspend, though.

On resume, I need to call hwclock --hctosys to update the system clock.  I 
thought that had been fixed, but it's not in.  (Maybe it's in -mm?)

If I suspend with ohci and the pegasus ethernet thingy loaded, it suspends 
fine but freezes on resume.  Unloading the modules makes it happy.

On resume, my processor is in the C2 ACPI state, which can best be described 
as "amazingly slow".  I don't know how to get it back to normal.  (Go ahead 
and eat the batter faster, it's so slow I get less done on a full charge this 
way anyway!)  Oddly, I have NOT enabled CPU throttling (the manager is 
"performance"), so this is garbage left over from the quiesce not resuming 
the CPU power.

This week is insane for me, but I hope to have a little time to thump on it 
this weekend...

Would trying an -mm kernel be a good idea here?  (I'll upgrade to -test11 in a 
bit, but I don't think there was any suspend work in here...)

Rob
