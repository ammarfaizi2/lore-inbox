Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965130AbWDNKQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965130AbWDNKQV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 06:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965132AbWDNKQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 06:16:21 -0400
Received: from tim.rpsys.net ([194.106.48.114]:13989 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S965130AbWDNKQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 06:16:20 -0400
Subject: Behaviour change of /dev/fb0?
From: Richard Purdie <rpurdie@rpsys.net>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 14 Apr 2006 11:16:08 +0100
Message-Id: <1145009768.6179.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ignoring whether this is a good idea or not, under 2.6.15 you could run

dd if=/dev/zero of=/dev/fb0

which would clear the framebuffer. It would end up saying "dd: /dev/fb0:
No space left on device".

Under 2.6.16 (and a recent git kernel), the same command clears the
screen but then hangs. Was the change in behaviour intentional? 

I've noticed this on a couple of ARM based Zaurus handhelds under both
w100fb and pxafb.

Richard

