Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbTL2Fa4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 00:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbTL2Fa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 00:30:56 -0500
Received: from 205-158-62-67.outblaze.com ([205.158.62.67]:64216 "EHLO
	spf13.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S262794AbTL2Fay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 00:30:54 -0500
Message-ID: <20031229053053.30157.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Perry Gilfillan" <perrye@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Mon, 29 Dec 2003 11:30:53 +0600
Subject: RETRACTION: 2.4.23 segfaults on cat /proc/modules
X-Originating-Ip: 68.12.215.127
X-Originating-Server: ws5-3.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RETRACTION:  I just figured out what was going on.  It was all a typo in grub.conf.

I had originaly called the kernel image bzImage-2.4.23.kdbg.  I had a script that copied bzImage and System.map to /boot, applying -2.4.23.kdbg to them.  The script disapeared along with the directory linux-2.4.23-kgdb when I cleaned it out before applying the new patches.  When I recreated the script, I used -2.4.23.kgdb, while grub.conf still used kdbg.

I would have been clued in if depmod had shown errors in the boot log.  The kernel I inadvertantly was using did have module loading enabled,  but no modules were configured in the kernel since kgdb had not yet realeased the latest version.  I had module loading enabled so I could work on the v3tv modules.

The i2c modules in the lsmod listing below are from the new i2c and lm_sensors patches.  They loaded on the wrong kernel without missing symbols.  I got a long list of missing symbols when I went back to freshen the kernel and finnaly got tipped off on what was wrong.

It's been educational, and I'm better prepared for my next challenge with the v3tv drivers.

It's all there at http://gilfillan.org:8000/Oopsen/ ( no I'm not afraid to admit my own mistakes )

Thanks for your attention,

Perry

-- 
______________________________________________
Check out the latest SMS services @ http://www.linuxmail.org 
This allows you to send and receive SMS through your mailbox.


Powered by Outblaze
