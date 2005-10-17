Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbVJQRqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbVJQRqO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 13:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbVJQRqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 13:46:13 -0400
Received: from gherkin.frus.com ([192.158.254.49]:48553 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S1751053AbVJQRqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 13:46:13 -0400
Subject: vesafb_blank() vs. Toshiba 730XCDT notebook
To: linux-kernel@vger.kernel.org
Date: Mon, 17 Oct 2005 12:46:12 -0500 (CDT)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20051017174612.4ECE7DBA1@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for not reporting this problem sooner...  The system with
the problem doesn't get powered-up as often as it probably should.

Is there a way to disable or otherwise control the display blanking
feature that was added after 2.6.13?  I've got a Toshiba notebook
(730XCDT -- Pentium 150MMX) for which I'm using the Vesa FB driver.
When the machine has been idle for some time and the driver attempts
to powerdown the display, rather than the display going blank, it goes
gray with several strange lines.  When I hit the "shift" key or other-
wise wake up the display, the old video state is not fully restored:
the image is badly distorted (looks like video memory corruption --
moving the mouse pointer around causes the affected areas to refresh
properly) until I switch from X11 to a virtual console and then back
to X11.

Also, when I first go into X11, the display goes into a mode that has
the appearance of film melting in front of a hot projector lamp :-(.
In the background I see faint tile outlines.  Finally, the display goes
into the proper mode and all is well until I leave the machine idle for
a few minutes as described above.

None of this behavior was present in 2.6.13: when I invoked "startx",
the display would simply go blank until the expected background image
(standard X11 moire) appeared.  The first kernel I tried that has the
display problems is 2.6.14-rc1.  I'm only seeing these problems on the
Toshiba: my other systems behave fine.

Thanks in advance for any help/guidance those in the know can provide.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
