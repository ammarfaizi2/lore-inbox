Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVAMThT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVAMThT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 14:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVAMTgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 14:36:25 -0500
Received: from village.ehouse.ru ([193.111.92.18]:4877 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S261365AbVAMTec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 14:34:32 -0500
From: "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
To: linux-kernel@vger.kernel.org
Subject: module's parameters could not be set via sysfs in 2.6.11-rc1?
Date: Thu, 13 Jan 2005 22:34:30 +0300
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501132234.30762.rathamahata@ehouse.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

It looks like module parameters are not setable via sysfs in 2.6.11-rc1

E.g.
arise parameters # echo -en Y > /sys/module/usbcore/parameters/old_scheme_first
-bash: /sys/module/usbcore/parameters/old_scheme_first: Permission denied
arise parameters # id
uid=0(root) gid=0(root) groups=0(root),1(bin),2(daemon),3(sys),4(adm),6(disk),10(wheel),11(floppy),20(dialout),26(tape),27(video)
arise parameters # 
arise parameters # ls -la /sys/module/usbcore/parameters/old_scheme_first
-rw-r--r--  1 root root 0 Jan 13 22:22 /sys/module/usbcore/parameters/old_scheme_first
arise parameters # 

This is sad because it seems that my usb flash stick (transcebd jetflash)
doesn't like new USB device initialization scheme introduced in 2.6.10.

-- 
Sergey S. Kostyliov <rathamahata@ehouse.ru>
Jabber ID: rathamahata@jabber.org
