Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbTKYPwD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 10:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbTKYPwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 10:52:02 -0500
Received: from turing.informatik.Uni-Halle.DE ([141.48.9.50]:49095 "EHLO
	turing.informatik.uni-halle.de") by vger.kernel.org with ESMTP
	id S261522AbTKYPwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 10:52:00 -0500
Message-ID: <3FC37A9E.6030002@abeckmann.de>
Date: Tue, 25 Nov 2003 16:51:58 +0100
From: Andreas Beckmann <sparclinux@abeckmann.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: sparclinux@abeckmann.de
Subject: 2.4.23-rc4 sparc64 compile problem: drivers/char/drm/ffb_drv.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling ffb_drv.c into the kernel (CONFIG_DRM_FFB=y) fails with
ffb_drv.c:386: error: redefinition of `ffb_options'
drm_drv.h:138: error: `ffb_options' previously defined here

Compiling it as a module (CONFIG_DRM_FFB=m) works fine.

I think this was introduced by

ChangeSet 1.1063.39.5 2003/09/01 17:05:39 m.c.p@wolk-project.de
   [PATCH] Update DRI/DRM so XFree v4.3.0 and above works

when all drivers in drivers/char/drm/ except ffb*.* were modified.

Removing DRM(options) (that generates ffb_options) from ffb_drv.c makes 
it compile again. But ffb still needs the cleanup performed on the other 
drivers and possibly XFree 4.3 fixes.


Andreas

Please CC: me in your replys, as I'm not subscribed to lkml.


