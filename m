Return-Path: <linux-kernel-owner+w=401wt.eu-S932541AbWLZMMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbWLZMMN (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 07:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbWLZMMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 07:12:13 -0500
Received: from mxout005.mail.hostpoint.ch ([217.26.49.184]:53062 "EHLO
	mxout005.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932541AbWLZMMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 07:12:12 -0500
X-Authenticated-Sender-Id: andreas.jaggi@waterwave.ch
Date: Tue, 26 Dec 2006 13:12:27 +0100
From: Andreas Jaggi <andreas.jaggi@waterwave.ch>
To: linux-kernel@vger.kernel.org
Cc: Michael Hanselmann <linux-kernel@hansmi.ch>,
       Yu Luming <luming.yu@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] via-pmu-backlight.c backlight_device_register build fix
Message-ID: <20061226131227.66722921@localhost>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.6; powerpc-unknown-linux-gnu)
X-Face: ~'tADa1faeey.m~:h}X+Y,gdK*18AQQun"fQ6e-FE@0&cEf&{p1`$bqU[Zr^D]G<fqBU;"P
 2X\'U16EWS^zbPX?:[nRF)evEb_4|[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update call to backlight_device_register in via-pmu-backlight.c after argument change.

Signed-off-by: Andreas Jaggi <andreas.jaggi@waterwave.ch>

diff --git a/drivers/macintosh/via-pmu-backlight.c b/drivers/macintosh/via-pmu-backlight.c
index 6c29fe7..801a974 100644
--- a/drivers/macintosh/via-pmu-backlight.c
+++ b/drivers/macintosh/via-pmu-backlight.c
@@ -147,7 +147,7 @@ void __init pmu_backlight_init()
 
 	snprintf(name, sizeof(name), "pmubl");
 
-	bd = backlight_device_register(name, NULL, &pmu_backlight_data);
+	bd = backlight_device_register(name, NULL, NULL, &pmu_backlight_data);
 	if (IS_ERR(bd)) {
 		printk("pmubl: Backlight registration failed\n");
 		goto error;
