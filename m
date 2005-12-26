Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbVLZNUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbVLZNUL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 08:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbVLZNUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 08:20:10 -0500
Received: from [85.8.13.51] ([85.8.13.51]:17847 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750723AbVLZNUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 08:20:09 -0500
Message-ID: <43AFEDF8.2060404@drzeus.cx>
Date: Mon, 26 Dec 2005 14:19:52 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mail/News 1.5 (X11/20051129)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [RFC][MMC] Buggy cards need to leave programming state
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've gotten two reports for cards that just crap out during write
transfers. The solution I've given them is to make the mmc block layer
wait for the card to leave programming state.

>From the specs I have, this behaviour is required for SD cards, but not
MMC. The two bug reports I have are both for MMC though. So either these
cards are broken, or they patch works simply because it adds an extra delay.

(Oddly enough, I have yet to receive a report of a SD card that
misbehaves because of this.)

Russell, what's your take on this? Play it safe and put this patch in
mainline or do you have some ideas to test first?


Threads for bug reports:

http://list.drzeus.cx/pipermail/wbsd-devel/2005-October/000351.html
http://list.drzeus.cx/pipermail/wbsd-devel/2005-November/000388.html

Entries with relevant dumps:

http://list.drzeus.cx/pipermail/wbsd-devel/2005-November/000396.html
http://list.drzeus.cx/pipermail/wbsd-devel/2005-October/000361.html

Rgds
Pierre
