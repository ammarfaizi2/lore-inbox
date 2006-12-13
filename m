Return-Path: <linux-kernel-owner+w=401wt.eu-S1751601AbWLMOKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbWLMOKg (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 09:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751604AbWLMOKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 09:10:36 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:3002 "EHLO ore.jhcloos.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600AbWLMOKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 09:10:35 -0500
X-Greylist: delayed 1409 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 09:10:35 EST
X-Hashcash: 1:23:061213:linux-kernel@vger.kernel.org::KCaH8Yrea9whQtXx:0000000000000000000000000000000009Em5
From: James Cloos <cloos@jhcloos.com>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: drivers/video/aty/radeon_backlight.c
Copyright: Copyright 2006 James Cloos
X-Hashcash: 1:23:061213:linux-fbdev-devel@lists.sourceforge.net::MKWWmCgMj608GlBX:0000000000000000000002KbG+
Date: Wed, 13 Dec 2006 08:46:24 -0500
Message-ID: <m3irgflxh4.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/23.0.0 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are there any dependencies in $subject which would preclude changing
drivers/video/Kconfig with:

 config FB_RADEON_BACKLIGHT
         bool "Support for backlight control"
-        depends on FB_RADEON && PMAC_BACKLIGHT
+        depends on FB_RADEON
         select FB_BACKLIGHT
         default y
         help
           Say Y here if you want to control the backlight of your display.

or is radeon_backlight.c only functional when -DCONFIG_PMAC_BACKLIGHT,
even though the pmac routines are all ifdef'ed?

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6
