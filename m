Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265172AbUAERRQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 12:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265205AbUAERRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 12:17:16 -0500
Received: from smtp2.dei.uc.pt ([193.137.203.229]:29083 "EHLO smtp2.dei.uc.pt")
	by vger.kernel.org with ESMTP id S265172AbUAERRI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 12:17:08 -0500
Date: Mon, 5 Jan 2004 17:16:43 +0000 (WET)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] psmouse info in 2.6.1-rc1
Message-ID: <Pine.LNX.4.58.0401051711170.23750@student.dei.uc.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-UC-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-DEI-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi there...
I don't really know if this is only in -rc1-mm1 but I suppose -rc1 is affected also.

The new changes in drivers/input/mouse/psmouse-base.c make that we don't have
anymore to give to kernel  psmouse_proto=imps, but only proto=imps , so the
info about it is wrong... Please apply the patch:

- --- linux-2.6.1-rc1-mm2/drivers/input/mouse/Kconfig     2004-01-05 10:51:16.000000000 +0100
+++ linux-2.6.1-rc1-mm2-mbn1/drivers/input/mouse/Kconfig        2004-01-05 13:34:26.000000000 +0100
@@ -30,7 +30,7 @@
                http://www.geocities.com/dt_or/gpm/gpm.html
          to take advantage of the advanced features of the touchpad.
          If you do not want install specialized drivers but want tapping
- -         working please use option psmouse.proto=imps.
+         working please use option proto=imps.

          If unsure, say Y.


- --
==================================================
Marcos Daniel Marado Torres AKA Mind Booster Noori
/"\               http://student.dei.uc.pt/~marado
\ /                       marado@student.dei.uc.pt
 X   ASCII Ribbon Campaign
/ \  against HTML e-mail and Micro$oft attachments
==================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Made with pgp4pine 1.76

iD8DBQE/+ZwAmNlq8m+oD34RAuUWAJ9XSnA+ECpsMp1fxQHnt1Hi0m2A8QCffdZ5
4SCPS9GM8NjUUVe7bGUg/dA=
=qAnS
-----END PGP SIGNATURE-----

