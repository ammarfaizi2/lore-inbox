Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbVC0Xhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbVC0Xhc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 18:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVC0Xhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 18:37:32 -0500
Received: from userf193.dsl.pipex.com ([62.188.53.193]:24756 "HELO
	mail.ezplanet.net") by vger.kernel.org with SMTP id S261618AbVC0Xh0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 18:37:26 -0500
Subject: imps2 mouse driver and bug 2082
From: Mauro Mozzarelli <mauro@ezplanet.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: EzPlanet
Date: Sun, 27 Mar 2005 23:37:22 +0000
Message-Id: <1111966642.5789.7.camel@helios.ezplanet.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The mouse driver, re-developed for kernel 2.6, ever since the earliest
2.6 release lost the ability to reset a broken link with an IMPS2 mouse
(this happens when disconnecting the mouse plug either physically or
through a "non imps2" KVM switch). The result is that the mouse can no
longer be controlled, with the only solution being a RE-BOOT!

This issue has been filed as bug 2082
(http://bugme.osdl.org/show_bug.cgi?id=2082) . A fix was posted for
2.6.8, but this patch never made its way into the kernel main stream.
"Vojtech", author of the 2.6 mouse driver, keeps modifying his code
version after version, therefore breaking compatibility with the posted
patch. I adapted the patch for 2.6.9 and 2.6.10 (there are now three
versions for 2.6.8, 2.6.9 and 2.6.10). Kernel 2.6.11(.6) was released
recently, still with the same bug, and would require further adaptation
of the posted patch.

I was wondering if some business related priority could be set for this
issue.

Given that most Linux deployments are in server farms, where boxes
share a console attached to a KVM that might good enough, but not
properly supporting IMPS2, please, could we include this patch in the
kernel main stream before adding support for any new mouse device that
hardly anyone running a server would be interested in?

Mauro


