Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbUG1Sxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbUG1Sxw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 14:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbUG1Sxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 14:53:52 -0400
Received: from scrye.com ([216.17.180.1]:37771 "EHLO mail.scrye.com")
	by vger.kernel.org with ESMTP id S262106AbUG1Sxu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 14:53:50 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Wed, 28 Jul 2004 12:53:42 -0600
From: Kevin Fenzi <kevin-kernel@scrye.com>
To: linux-kernel@vger.kernel.org
Subject: pmdisk/swusp1 (merged) with 2.6.8-rc2-mm1
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Message-Id: <20040728185346.45CE54189@voldemort.scrye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Greetings. 

I am a happy software suspend2 user, but with the recent merge of
pmdisk and swsusp1, I thought I would give it a try and see how far
along it's come. 

Using 2.6.8-rc2-mm1 (that has the merged pmdisk/swsusp) I booted
single user and unloaded all modules, then started a hibernate. 

It gets to: 

PM: Attempting to suspend to disk.

and then hangs. Machine has to be hard power cycled. 
Looking at the code the problem appears to be that my laptop is
reporting that it has "S4_bios" support. It doesn't, but swsup1 sees
the S4_bios in /proc/acpi/sleep and tries to call that instead of
swsusp1. 

Is there any way to disable detection of S4_bios?

Is there any way to get swsusp1 to use it's S4 instead of S4_bios?

I guess I can recompile with the calls to S4_bios removed and see how
things go. 

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQFBB/Y53imCezTjY0ERAhleAJsEaaiXoC05j9Wm/w51G9YSKPEwmwCdE/Ux
0dxA8IXceHabVDCw5BJTqfI=
=2wIb
-----END PGP SIGNATURE-----
