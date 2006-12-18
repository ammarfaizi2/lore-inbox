Return-Path: <linux-kernel-owner+w=401wt.eu-S1754263AbWLRQrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754263AbWLRQrb (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 11:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754262AbWLRQrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 11:47:31 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:42670 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754232AbWLRQra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 11:47:30 -0500
X-Originating-Ip: 24.148.236.183
Date: Mon, 18 Dec 2006 11:41:59 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: trivial@kernel.org
Subject: [PATCH] Remove suggestion that Kconfig files can use "requires" to
 list deps
Message-ID: <Pine.LNX.4.64.0612181138360.27491@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-14.754, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00,
	RCVD_IN_SORBS_DUL 2.05)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Remove the note in the documentation that suggests people can use
"requires" for dependencies in Kconfig files.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  at this point, AFAICT, all Kconfig files now use "depends on"
exclusively, except for three that still use "depends", but i've
already submitted a patch for that that should be in the pipeline
somewhere.


diff --git a/Documentation/kbuild/kconfig-language.txt b/Documentation/kbuild/kconfig-language.txt
index 536d5bf..658abb5 100644
--- a/Documentation/kbuild/kconfig-language.txt
+++ b/Documentation/kbuild/kconfig-language.txt
@@ -77,7 +77,7 @@ applicable everywhere (see syntax).
   Optionally, dependencies only for this default value can be added with
   "if".

-- dependencies: "depends on"/"requires" <expr>
+- dependencies: "depends on" <expr>
   This defines a dependency for this menu entry. If multiple
   dependencies are defined, they are connected with '&&'. Dependencies
   are applied to all other options within this menu entry (which also
