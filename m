Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751820AbWD1AVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbWD1AVB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 20:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbWD1AUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 20:20:42 -0400
Received: from ns2.suse.de ([195.135.220.15]:39893 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751818AbWD1AUh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 20:20:37 -0400
Date: Thu, 27 Apr 2006 17:18:55 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Jose Alberto Reguero <jareguero@telefonica.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>,
       Hans Verkuil <hverkuil@xs4all.nl>, Michael Krufky <mkrufky@linuxtv.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 10/24] fix saa7129 support in saa7127 module for pvr350 tv out
Message-ID: <20060428001855.GK18750@kroah.com>
References: <20060428001226.204293000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-saa7129-support-in-saa7127-module-for-pvr350-tv-out.patch"
In-Reply-To: <20060428001557.GA18750@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Jose Alberto Reguero <jareguero@telefonica.net>

This patch fixes tv-out support for the newer model of
the pvr350, which has a saa7129 instead of a saa7127
video encoder.

Signed-off-by: Jose Alberto Reguero <jareguero@telefonica.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/media/video/saa7127.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.16.11.orig/drivers/media/video/saa7127.c
+++ linux-2.6.16.11/drivers/media/video/saa7127.c
@@ -141,6 +141,7 @@ struct i2c_reg_value {
 static const struct i2c_reg_value saa7129_init_config_extra[] = {
 	{ SAA7127_REG_OUTPUT_PORT_CONTROL, 		0x38 },
 	{ SAA7127_REG_VTRIG, 				0xfa },
+	{ 0, 0 }
 };
 
 static const struct i2c_reg_value saa7127_init_config_common[] = {

--
