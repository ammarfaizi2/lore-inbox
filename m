Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264377AbUEXVEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbUEXVEq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 17:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbUEXVEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 17:04:46 -0400
Received: from mail.kroah.org ([65.200.24.183]:51431 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264377AbUEXVDZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 17:03:25 -0400
Date: Mon, 24 May 2004 14:02:27 -0700
From: Greg KH <greg@kroah.com>
To: marcelo.tosatti@cyclades.com
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [BK PATCH] PCI Express patches for 2.4.27-pre3
Message-ID: <20040524210227.GC5532@kroah.com>
References: <20040524210146.GA5532@kroah.com> <20040524210205.GB5532@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040524210205.GB5532@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet 1.1428, 2004/05/24 13:33:53-07:00, blujuice@us.ibm.com

[PATCH] PCI: PCI Express help in 2.4

Here is a patch for describing PCI access mode - help in 2.4.
This aligns the help with what is in 2.6.


 Documentation/Configure.help |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)


diff -Nru a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	Mon May 24 13:52:08 2004
+++ b/Documentation/Configure.help	Mon May 24 13:52:08 2004
@@ -4236,12 +4236,13 @@
   PCI-based systems don't have any BIOS at all. Linux can also try to
   detect the PCI hardware directly without using the BIOS.
 
-  With this option, you can specify how Linux should detect the PCI
-  devices. If you choose "BIOS", the BIOS will be used, if you choose
-  "Direct", the BIOS won't be used, and if you choose "Any", the
-  kernel will try the direct access method and falls back to the BIOS
-  if that doesn't work. If unsure, go with the default, which is
-  "Any".
+  With this option, you can specify how Linux should detect the
+  PCI devices. If you choose "BIOS", the BIOS will be used,
+  if you choose "Direct", the BIOS won't be used, and if you
+  choose "MMConfig", then PCI Express MMCONFIG will be used.
+  If you choose "Any", the kernel will try MMCONFIG, then the
+  direct access method and falls back to the BIOS if that doesn't
+  work. If unsure, go with the default, which is "Any".
 
 PCI device name database
 CONFIG_PCI_NAMES
