Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbUBWN5a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 08:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbUBWN5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 08:57:30 -0500
Received: from jik.kamens.brookline.ma.us ([66.92.77.120]:52110 "EHLO
	jik.kamens.brookline.ma.us") by vger.kernel.org with ESMTP
	id S261872AbUBWN4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 08:56:40 -0500
From: Jonathan Kamens <jik@kamens.brookline.ma.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16442.1685.962310.278496@jik.kamens.brookline.ma.us>
Date: Mon, 23 Feb 2004 08:56:37 -0500
To: linux-kernel@vger.kernel.org
Subject: Conclusion of my Promise PDC20262, SIIG SIi680 IDE controller problems
X-Mailer: VM 7.18 under Emacs 21.3.1
X-Bogosity: No, tests=bogofilter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wanted to let people know the final results of my efforts to resolve
problems I was having with Promise PDC20262 Ultra66 and SIIG SIi680
Ultra133 PCI IDE controllers.

Recall that I was getting frequent BadCRC errors from the PDC20262
controller with both 2.4.22-ac4 and 2.6.x.  I tried many suggestions
offered here for making the errors go away, and none of them worked.
The errors were not caused by the cable.

I finally bought a new SIIG UltraATA 133 controller with the SIi680
chipset.  The BadCRC errors went away with that controller, but I
ended up with a new problem -- my system regularly locked up hard
under 2.4.22-ac4.  When I tried switching to 2.6.2-rc1, I got even
more frequent lock-ups, but I suspect that they were unrelated the IDE
controller.

The happy ending to all of this is that I have been running
2.4.23-pac1 for weeks with no lockups.  So it would appear that there
was a bug of some sort in the IDE code that was fixed somewhere
between 2.4.22-ac4 and 2.4.23-pac1.

Perhaps this information will help someone track down similar problems
in the future.

Take care,

  jik
