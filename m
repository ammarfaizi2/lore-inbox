Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316106AbSFDDI4>; Mon, 3 Jun 2002 23:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316113AbSFDDIz>; Mon, 3 Jun 2002 23:08:55 -0400
Received: from mail301.mail.bellsouth.net ([205.152.58.161]:10834 "EHLO
	imf01bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S316106AbSFDDIx>; Mon, 3 Jun 2002 23:08:53 -0400
Message-ID: <3CFC2F3E.C710E348@bellsouth.net>
Date: Mon, 03 Jun 2002 23:08:46 -0400
From: Albert Cranford <ac9410@bellsouth.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [patch]2.5.20 i2c Config fix
Content-Type: multipart/mixed;
 boundary="------------08D5CEE985C2A56A7DE4158A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------08D5CEE985C2A56A7DE4158A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello Linus,
The following patch adds a check if CONFIG_SYSCTL is
configured before allowing CONFIG_I2C_PROC configuration.
Albert
-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
--------------08D5CEE985C2A56A7DE4158A
Content-Type: text/plain; charset=us-ascii;
 name="47-i2c-1-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="47-i2c-1-patch"

# leave CONFIG names as in kernel
--- linux/drivers/i2c/Config.in.orig	2002-05-05 23:38:06.000000000 -0400
+++ linux/drivers/i2c/Config.in	2002-05-16 01:00:36.000000000 -0400
@@ -43,7 +43,7 @@
 # This is needed for automatic patch generation: sensors code ends here
 
    dep_tristate 'I2C device interface' CONFIG_I2C_CHARDEV $CONFIG_I2C
-   dep_tristate 'I2C /proc interface (required for hardware sensors)' CONFIG_I2C_PROC $CONFIG_I2C
+   dep_tristate 'I2C /proc interface (required for hardware sensors)' CONFIG_I2C_PROC $CONFIG_I2C $CONFIG_SYSCTL
 
 fi
 endmenu

--------------08D5CEE985C2A56A7DE4158A--

