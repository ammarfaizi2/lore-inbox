Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbVLVEtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbVLVEtJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 23:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbVLVEtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:49:09 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:20688 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932390AbVLVEtH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:49:07 -0500
To: linux-m68k@vger.kernel.org
Subject: [PATCHSET] m68k: build fixes and sparse annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EpIO0-0004pp-EG@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 22 Dec 2005 04:49:04 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series against the mainline; most of it directly applies to m68k CVS,
except for #18 (dmasound_paula lvalues abuse) that is pulled from CVS and
#4 (misc/mac.c switch away from adb_request()) - that one does apply to CVS
but assumes that ADBREQ_RAW patch (present in CVS, but absent in mainline)
is reverted.

All patches affect only m68k or (in one patch) ppc/amiga; the latter is
a trivial renaming of a macro from amigahw.h.  IOW, it should be mergable
at any point without any impact on other architectures.  And in the
current mainline m68k still doesn't build...

Patches follow.  Please, review.
