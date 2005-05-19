Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVESWzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVESWzk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 18:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVESWzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 18:55:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47778 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261284AbVESWzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 18:55:35 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCHSET] namei fixes
Cc: akpm@osdl.org
Message-Id: <E1DYtvs-0007qF-U8@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 19 May 2005 23:56:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	OK, here comes a patch series that hopefully should close all
too-early-mntput() races in fs/namei.c.  Entire area is convoluted as
hell, so I'm splitting that series into _very_ small chunks.

	Patches alread in the tree close only (very wide) races in following
symlinks (see "busy inodes after umount" thread some time ago).  Unfortunately,
quite a few narrower races of the same nature were not closed.  Hopefully
this should take care of all of them.

	Please, review and test.  It survives local beating and AFAICS
it's correct, but that's a hell of a critical area.  Extra eyes would
be very welcome.

	Patches will be sent in separate mails; they are also available on
ftp.linux.org.uk/pub/people/viro/NAMEI*.  Series is based at 2.6.12-rc4
and yes, there are 19 patches in it.
