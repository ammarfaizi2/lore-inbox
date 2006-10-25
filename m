Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965213AbWJYULt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965213AbWJYULt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 16:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965225AbWJYULs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 16:11:48 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:41735 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965223AbWJYULs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 16:11:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=COrFtPnNocEOsUJsfi1PYq9ZiqUe4wWvkvPb86EMuewFt2F/+/u24C8atjo24BRrdWRDQo4dxxFW3JIxLOTWBH5xokMqJcy6gqo2Z+2mHDQPTeEkbZr32ftxuZ80jiFChuH5g8g70XTsAFt1A7Lk3p8Yz35gM4qcQTOdNil+xY4=
Message-ID: <6b4e42d10610251311r27f672bbr519158411b90d569@mail.gmail.com>
Date: Wed, 25 Oct 2006 13:11:42 -0700
From: "Om Narasimhan" <om.turyx@gmail.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: HPET : Legacy Routing Replacement Enable (02/03) - Generic
Cc: randy.dunlap@oracle.com, omanakuttan.potty@sun.com, clemens@ladisch.de,
       vojtech@suse.cz, bob.picco@hp.com, venkatesh.pallipadi@intel.com,
       omanakuttan@imap.cc, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 02/03 : Generic code changes.
------
Signed-Off-by : Om Narasimhan <om.turyx@gmail.com>

 include/linux/acpi.h |    1 +
 include/linux/hpet.h |    7 +++++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 88b5dfd..aac4a89 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -220,6 +220,7 @@ enum acpi_interrupt_id {
 };

 #define	ACPI_SPACE_MEM		0
+#define	ACPI_HPET_LRR_CAP	0x8000

 struct acpi_gen_regaddr {
 	u8  space_id;
diff --git a/include/linux/hpet.h b/include/linux/hpet.h
index 707f7cb..6c31473 100644
--- a/include/linux/hpet.h
+++ b/include/linux/hpet.h
@@ -119,6 +119,13 @@ int hpet_register(struct hpet_task *, in
 int hpet_unregister(struct hpet_task *);
 int hpet_control(struct hpet_task *, unsigned int, unsigned long);

+
+/* these are used by time.c */
+extern void i8254_timer_resume(void);
+extern int using_apic_timer;
+extern int acpi_hpet_lrr;
+extern int hpet_lrr_force;
+
 #endif /* __KERNEL__ */

 struct hpet_info {
