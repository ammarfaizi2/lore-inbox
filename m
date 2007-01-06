Return-Path: <linux-kernel-owner+w=401wt.eu-S1751386AbXAFNTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbXAFNTP (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 08:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbXAFNTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 08:19:14 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:21582 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbXAFNTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 08:19:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent:from;
        b=anwAsZt9Es9oK9PxeQjc3WrJoOrRNvkR9qfDRwHwy4NExHD7TkKG80WwH23BwJmpiIypacIE10BcYKH+9U6OGYhAFI9yVOiV9EsM6tVWKrqSgwHnKzjG6gT+sG7lilUWEcH57RGuoO5SJf7RfxkyYKnlf8utyaVv+ujH6AWs7fo=
Date: Sat, 6 Jan 2007 15:18:52 +0200
To: jkosina@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.20-rc3] HID-Core: Tiny patch to remove a kmalloc cast
Message-ID: <20070106131852.GF19020@Ahmed>
Mail-Followup-To: jkosina@suse.cz, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm really shy from the size of the patch :).

Signed-off-by: Ahmed Darwish <darwish.07@gmail.com>

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 18c2b3c..2fcfdbb 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -656,7 +656,7 @@ struct hid_device *hid_parse_report(__u8 *start, unsigned size)
 	for (i = 0; i < HID_REPORT_TYPES; i++)
 		INIT_LIST_HEAD(&device->report_enum[i].report_list);
 
-	if (!(device->rdesc = (__u8 *)kmalloc(size, GFP_KERNEL))) {
+	if (!(device->rdesc = kmalloc(size, GFP_KERNEL))) {
 		kfree(device->collection);
 		kfree(device);
 		return NULL;


-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
