Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVDDRm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVDDRm3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 13:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVDDRm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 13:42:28 -0400
Received: from pop.gmx.net ([213.165.64.20]:21935 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261307AbVDDRmO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 13:42:14 -0400
X-Authenticated: #222435
From: Jonas Diemer <diemer@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: security issue: hard disk lock
Date: Mon, 4 Apr 2005 19:42:10 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504041942.10976.diemer@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I don't know if you guys already know, there is a possible security risk with 
all modern desktop-pcs and ata hard drives. In short:

Modern ata drives can be locked by password. This lock could be set by a 
malicous software. This security feature can be frozen, so no programs can 
set a lock until the next reboot. Ususally, the BIOS should take care of 
locking the security feature, but most desktop BIOSes (unlike laptop BIOSes) 
fail to do so. Once a lock is set and the password is unknown, the drive is 
trash.

See http://www.heise.de/ct/english/05/08/172/ for more details.

In the above article, a patched hdparm is used to freeze the drive's security 
features. This can be used during boot to prevent programs from setting a 
password. However, a malicous program could infect the computer and install 
itself in the boot sequence prior to the execution of hdparm...

I figured there could be a kernel compiled-in option that will make the kernel 
lock all drives found during bootup. then, a malicous program would need to 
install a different kernel in order to harm the drive, which would be much 
more secure.

What do you think of this? 

Regards,
Jonas

PS: Please CC me in replies, I am not subscribed to the list.
