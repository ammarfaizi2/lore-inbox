Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262677AbUKLXvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262677AbUKLXvF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbUKLXss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:48:48 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:41351 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262718AbUKLX0x convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:26:53 -0500
Subject: [PATCH] I2C fixes for 2.6.10-rc1
In-Reply-To: <20041112232604.GA17203@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 12 Nov 2004 15:26:45 -0800
Message-Id: <11003020054093@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2093, 2004/11/12 11:39:51-08:00, greg@kroah.com

I2C: fix up some out of date Documentation

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 Documentation/i2c/dev-interface |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/Documentation/i2c/dev-interface b/Documentation/i2c/dev-interface
--- a/Documentation/i2c/dev-interface	2004-11-12 15:22:53 -08:00
+++ b/Documentation/i2c/dev-interface	2004-11-12 15:22:53 -08:00
@@ -3,7 +3,7 @@
 the /dev interface. You need to load module i2c-dev for this.
 
 Each registered i2c adapter gets a number, counting from 0. You can
-examine /proc/bus/i2c to see what number corresponds to which adapter.
+examine /sys/class/i2c-dev/ to see what number corresponds to which adapter.
 I2C device files are character device files with major device number 89
 and a minor device number corresponding to the number assigned as 
 explained above. They should be called "i2c-%d" (i2c-0, i2c-1, ..., 
@@ -19,7 +19,7 @@
 knows about i2c, there is not much choice.
 
 Now, you have to decide which adapter you want to access. You should
-inspect /proc/bus/i2c to decide this. Adapter numbers are assigned
+inspect /sys/class/i2c-dev/ to decide this. Adapter numbers are assigned
 somewhat dynamically, so you can not even assume /dev/i2c-0 is the
 first adapter.
 

