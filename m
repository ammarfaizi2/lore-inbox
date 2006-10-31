Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946036AbWJaV2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946036AbWJaV2p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 16:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946030AbWJaV2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 16:28:45 -0500
Received: from mail.hirnfrei.org ([217.160.176.83]:19365 "EHLO
	brainNG.hirnfrei.org") by vger.kernel.org with ESMTP
	id S1946036AbWJaV2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 16:28:44 -0500
From: =?iso-8859-1?q?J=F6rg_Hundertmarck?= <joerg@hundertmarck.de>
To: linux-kernel@vger.kernel.org
Subject: Simple extension to psmouse driver (tp-scroll in kernel mode)
Date: Tue, 31 Oct 2006 23:28:17 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610312228.21804.joerg@hundertmarck.de>
X-MC: malicious code scan successful
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello world,

I've wrote a simple extension to the psmouse driver. It's an emulation for the
scrolling wheel on TrackPoint mice. It's functionally the same like the userspace
daemon tp-scroll but it doesn't lag if the system has full load. The emulation
starts when you press the middle mouse button, then you can "scroll" up and
down by moving the mouse into the desired direction. It stops when the button
released. When you press and release the button without move, the button event
is transfered. This feature is not enabled by default, you need to set
CONFIG_MOUSE_TPWHEEL=y.

Here's the patch:
http://www.hirnfrei.org/~joerg/linux_patches/linux-2.6.17-gentoo-r7-tp-scroll.patch

The patch is tested against the the 2.6.17 and 2.6.18.1 kernel source.

I hope that's the correct mailing list and my code is usefull.

Greets
Joerg Hundertmarck
