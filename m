Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbUDWWCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbUDWWCo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 18:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUDWWCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 18:02:44 -0400
Received: from mail.rty.ca ([64.56.132.29]:55049 "EHLO rty.ca")
	by vger.kernel.org with ESMTP id S261582AbUDWWCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 18:02:42 -0400
Message-ID: <42822.68.144.162.3.1082757748.squirrel@webmail.rty.ca>
Date: Fri, 23 Apr 2004 16:02:28 -0600 (MDT)
Subject: Si3112 S-ATA bug preventing use of udma5.
From: "Brenden Matthews" <brenden@rty.ca>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6.5 (not sure about other versions) there is a bug/problem in the
drivers/ide/pci/siimage.c driver.  I have only tested this with my Si3112
chipset on an ASUS A7N8X-Deluxe mobo.  I did not discover this fix, and
I'll post a url below to the original source.  No idea if this has been
fixed/looked at already, but it definitely needs to be resolved.

hdparm -t speed without fix: 16mb/s
hdparm -t speed with fix: 55mb/s

http://forums.gentoo.org/viewtopic.php?t=111300

Incase the link is down/broken, to fix the bug change line 269 of
drivers/ide/pci/siimage.c from:

        u32 speedt              = 0;

to:
        u16 speedt              = 0;



Regards,
Brenden
