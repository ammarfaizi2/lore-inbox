Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265215AbUAER0p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 12:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbUAER0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 12:26:45 -0500
Received: from smtp.dei.uc.pt ([193.137.203.228]:41176 "EHLO smtp.dei.uc.pt")
	by vger.kernel.org with ESMTP id S265215AbUAERZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 12:25:59 -0500
Date: Mon, 5 Jan 2004 17:25:41 +0000 (WET)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] mouse info in 2.6.1-rc1
Message-ID: <Pine.LNX.4.58.0401051716590.23750@student.dei.uc.pt>
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

The new changes about synaptics (I think that it was it) made that we don't have
anymore a boolean (selectable) option in Device Drivers -> Input Device Support
- -> Mouse Interface;
Although, it we so to the "non-selectable" option Mouse Interface, the help info
exists and talks about "slect it if...", so...

 Please apply the patch:

- --- linux-2.6.1-rc1-mm2/drivers/input/Kconfig   2003-12-18 03:58:08.000000000 +0100
+++ linux-2.6.1-rc1-mm2-mbn1/drivers/input/Kconfig      2004-01-05 13:38:10.000000000 +0100
@@ -28,17 +28,6 @@
        tristate "Mouse interface" if EMBEDDED
        default y
        depends on INPUT
- -       ---help---
- -         Say Y here if you want your mouse to be accessible as char devices
- -         13:32+ - /dev/input/mouseX and 13:63 - /dev/input/mice as an
- -         emulated IntelliMouse Explorer PS/2 mouse. That way, all user space
- -         programs (includung SVGAlib, GPM and X) will be able to use your
- -         mouse.
- -
- -         If unsure, say Y.
- -
- -         To compile this driver as a module, choose M here: the
- -         module will be called mousedev.

 config INPUT_MOUSEDEV_PSAUX
        bool "Provide legacy /dev/psaux device" if EMBEDDED


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

iD8DBQE/+Z4ZmNlq8m+oD34RArVtAKDJjHjADGuxtCCT9RHC98s7hDBoOACcDfIT
6Zc5scaGgrtRoOOVBc8RPbA=
=cNaw
-----END PGP SIGNATURE-----

