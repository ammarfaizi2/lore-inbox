Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263420AbTKFIQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 03:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbTKFIQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 03:16:59 -0500
Received: from badenpowell.cs.ubc.ca ([142.103.6.71]:37824 "EHLO
	badenpowell.cs.ubc.ca") by vger.kernel.org with ESMTP
	id S263420AbTKFIQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 03:16:58 -0500
Date: Thu, 6 Nov 2003 00:16:57 -0800 (PST)
From: Dustin Lang <dalang@cs.ubc.ca>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Re:No backlight control on PowerBook G4
In-Reply-To: <20031106090132.B18367@tarantel.rz.fh-muenchen.de>
Message-ID: <Pine.GSO.4.53.0311060000400.10772@columbia.cs.ubc.ca>
References: <Pine.GSO.4.53.0311021038450.3818@columbia.cs.ubc.ca>
 <1067820334.692.38.camel@gaston> <1067878624.7695.15.camel@sonja>
 <1067896476.692.36.camel@gaston> <1067976347.945.4.camel@sonja>
 <1068078504.692.175.camel@gaston> <20031106090132.B18367@tarantel.rz.fh-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -1 IN_REP_TO,REFERENCES,USER_AGENT_PINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This thread is now a bit off-topic, since the solution I'm talking about
is in XFree86 rather than the kernel, but I thought I'd just post it here
so that the next person who hits on this problem can find the answer in
the archives.

To reply to my own post: the patch contributed by Guido Guenther to the
XFree86 CVS tree, which was meant for GeForce4-in-PowerBooks, also works
for me on my GeForceFX Go 5200 as found in some PowerBooks (PCI ID
10de:0329).  To get this to work you'll have to grab the CVS sources, find
the part that checks what chipset you have, and edit it so that your chip
passes the test.  (Hint:
xc/programs/Xserver/hw/xfree86/drivers/nv/nv_driver.c :
NVBacklightEnable).  You'll also need to make sure DPMS is turned on
(hint: read "man XF86Config-4" carefully).  The usual disclaimers apply:
this hack will probably destroy your video card, make you lose your hair,
and microwave your cat.  It worked for me, and my hair and cat are fine,
but that's just because I'm lucky.

Laters,
dstn.

