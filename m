Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbTI3Xu0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 19:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbTI3Xu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 19:50:26 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:13441
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S261788AbTI3XuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 19:50:21 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Keyboard dead on bootup on -test6.
Date: Tue, 30 Sep 2003 16:32:01 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309301632.01498.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since I switched to test6, my stuck-key problems went away.  (Thank you.  Good 
work.  Judging by the repeat speed, it's back to using hardware repeat.)

However, a problem I'd seen before resurfaced.  Sometimes when I boot up the 
keyboard is completely dead.  It just did this to me (had to use the power 
button, because of course ctrl-alt-del did nothing), and I compared the boot 
logs:

This is what it looks like when it works normally:

Sep 30 16:18:28 localhost kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Sep 30 16:18:28 localhost kernel: input: AT Translated Set 2 keyboard on 
isa0060/serio0
Sep 30 16:18:28 localhost kernel: serio: i8042 KBD port at 0x60,0x64 irq 1

This was the failure:

Sep 30 16:17:31 localhost kernel: atkbd.c: Unknown key pressed (raw set 0, 
code 0xfc, data 0xfc, on isa0060/serio1).
Sep 30 16:17:31 localhost kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Sep 30 16:17:31 localhost kernel: serio: i8042 KBD port at 0x60,0x64 irq 1

Under -test5, that failure would have left me with a stuck key endlessly 
repeating (and an otherwise dead keyboard).  Now at least the stuck key part 
has gone away, but the keyboard is still dead until I power cycle the 
machine.

I continue to be using a thinkpad iSeries, I believe it's a 1200C...

Rob


