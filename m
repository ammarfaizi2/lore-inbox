Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265708AbTL3JkK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 04:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265698AbTL3JkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 04:40:09 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:45966
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S265708AbTL3JkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 04:40:06 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: linux-kernel@vger.kernel.org
Subject: Spurious double-clicks in 2.6.0
Date: Mon, 29 Dec 2003 23:54:14 -0600
User-Agent: KMail/1.5.4
Cc: Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312292354.15084.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently had the opportunity to compare 2.6 and 2.4 on my thinkpad, and 
although most things are greatly improved in 2.6, one thing stands out.

When I click on things in 2.6, about 1% of the time it double-clicks instead.  
(Clicking on a titlebar to raise the window causes it to roll up instead, 
clicking on a scrollbar causes it to page down twice instead of once, etc.  
I'm always afraid that pulling up the top left window menu (to move it to 
another desktop, make it always on top, etc) will kill the window instead...)

This just doesn't happen under 2.4: I used the default kernel of Fedora Core 1 
for several days after a recent reinstall before putting 2.6 back on the box.  
But the input core doesn't seem to have this detail yet.

In 2.4 there seems to be some minimum time required between clicks to count as 
a double-click, which nicely filters out this kind of suprious electrical 
contact bounce thing.  (This makes sense: a human being simply CAN'T click 
twice within 1/20th of a second.  The mouse driver should drop a second click 
that comes faster than that: it's keybounce from the previous click.)

Rob

