Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbVAHFer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbVAHFer (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 00:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbVAHFer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 00:34:47 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:59114 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261787AbVAHFep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:34:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=LEHaYyjUfAulE+eSSrJ7duGnt2VctpsMDolpkxLjlFAW6FqZhDRenonMqzV78HAY6vp0ZMjpvFmnFTcYbcE2HrJg80y630/Tl1RJ0w/fS2SojR1Vt+O1aZjDWNzGDQq3ZkMV87n/laZ8qRZ5qqX2bIEracECqiKk6OVGfdWyIYo=
Message-ID: <9e47339105010721347fbeb907@mail.gmail.com>
Date: Sat, 8 Jan 2005 00:34:44 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Export symbol from I2C eeprom driver
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_752_3960100.1105162484931"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_752_3960100.1105162484931
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Trivial patch to export a symbol from the eeprom driver. Currently
there are no exported symbols. The symbol lets the radeon DRM driver
link to it and modprobe will then force it to load along with the
radeon driver.

Signed off by: Jon Smirl <jonsmirl@gmail.com>

-- 
Jon Smirl
jonsmirl@gmail.com

------=_Part_752_3960100.1105162484931
Content-Type: text/x-patch; name="eeprom.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="eeprom.patch"

#signed off by: Jon Smirl <jonsmirl@gmail.com>
=3D=3D=3D=3D=3D drivers/i2c/chips/eeprom.c 1.14 vs edited =3D=3D=3D=3D=3D
--- 1.14/drivers/i2c/chips/eeprom.c=092004-11-08 19:37:27 -05:00
+++ edited/drivers/i2c/chips/eeprom.c=092005-01-08 00:27:54 -05:00
@@ -85,7 +85,8 @@
 =09.detach_client=09=3D eeprom_detach_client,
 };
=20
-static int eeprom_id;
+int eeprom_id;
+EXPORT_SYMBOL(eeprom_id);
=20
 static void eeprom_update_client(struct i2c_client *client, u8 slice)
 {

------=_Part_752_3960100.1105162484931--
