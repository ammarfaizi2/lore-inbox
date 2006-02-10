Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbWBJAqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbWBJAqo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 19:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbWBJAqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 19:46:44 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:58885 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750907AbWBJAqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 19:46:43 -0500
Date: Fri, 10 Feb 2006 01:46:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: v4l-dvb-maintainer@linuxtv.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/media/dvb/bt8xx/: make 2 structs static
Message-ID: <20060210004643.GL3524@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global structs static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/media/dvb/bt8xx/bt878.c |    2 +-
 drivers/media/dvb/bt8xx/dst.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.16-rc2-mm1-full/drivers/media/dvb/bt8xx/bt878.c.old	2006-02-09 22:09:00.000000000 +0100
+++ linux-2.6.16-rc2-mm1-full/drivers/media/dvb/bt8xx/bt878.c	2006-02-09 22:09:07.000000000 +0100
@@ -382,7 +382,7 @@
 EXPORT_SYMBOL(bt878_device_control);
 
 
-struct cards card_list[] __devinitdata = {
+static struct cards card_list[] __devinitdata = {
 
 	{ 0x01010071, BTTV_BOARD_NEBULA_DIGITV,			"Nebula Electronics DigiTV" },
 	{ 0x07611461, BTTV_BOARD_AVDVBT_761,			"AverMedia AverTV DVB-T 761" },
--- linux-2.6.16-rc2-mm1-full/drivers/media/dvb/bt8xx/dst.c.old	2006-02-09 22:09:21.000000000 +0100
+++ linux-2.6.16-rc2-mm1-full/drivers/media/dvb/bt8xx/dst.c	2006-02-09 22:09:29.000000000 +0100
@@ -602,7 +602,7 @@
 
 */
 
-struct dst_types dst_tlist[] = {
+static struct dst_types dst_tlist[] = {
 	{
 		.device_id = "200103A",
 		.offset = 0,

