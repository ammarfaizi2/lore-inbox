Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932535AbWBPPBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbWBPPBE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 10:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbWBPPBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 10:01:04 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:41607 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932535AbWBPPBB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 10:01:01 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 0/1] swsusp: fix breakage with swap on LVM
Date: Thu, 16 Feb 2006 15:58:57 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, Dave Jones <davej@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602161558.57702.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In the following two replies to this message there are two versions of
the same fix, one of which applies to 2.6.16-rc3 and the second to the recent
-mm.

The fix is needed to restore the compatibility with the older code that
allowed to suspend even if the kernel command line didn't contain the
"resume=" argument.  This feature is necessary so that swsusp can work
in the default Fedora setup where the swap partition is on an LVM.

I consider the first patch, against 2.6.16-rc3, as an urgent fix that should
go in 2.6.16, if possible.  It has been tested by Dave and evidently fixes the
Fedora issue.  Unfortunately it doesn't apply to the recent -mm, because
in -mm the code in question is split between mm/swapfile.c and
kernel/power/swap.c, so the other patch is needed.

Please apply.

Greetings,
Rafael

