Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWJHPEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWJHPEk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 11:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWJHPEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 11:04:40 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:23178 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751211AbWJHPEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 11:04:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type;
        b=E8yzPLDvqz2S8JC2xx3TclIe8Ajj69rogYtXz4BB9O6jsb9xivUpTfsE+CUY9hIJwRZwBR1qdbV+fZrMNTkNrmyEOP/6RG+pD8Y9EpeNnOW53EG+WLuyCzMIeT3yAdH5bhbjPXn6HBI86eRrSdyr9an+J2um5ITONam8lNSHnJo=
Message-ID: <45291371.2000805@gmail.com>
Date: Sun, 08 Oct 2006 20:34:17 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] user struct irq_chip instead of struct hw_interrupt_type
Content-Type: multipart/mixed;
 boundary="------------080406090404090301060808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080406090404090301060808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------080406090404090301060808
Content-Type: text/x-patch;
 name="io_apic.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="io_apic.c.diff"

diff --git a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
index b7287fb..eafd93e 100644
--- a/arch/i386/kernel/io_apic.c
+++ b/arch/i386/kernel/io_apic.c
@@ -2594,7 +2594,7 @@ static void set_ht_irq_affinity(unsigned
 }
 #endif
 
-static struct hw_interrupt_type ht_irq_chip = {
+static struct irq_chip ht_irq_chip = {
 	.name		= "PCI-HT",
 	.mask		= mask_ht_irq,
 	.unmask		= unmask_ht_irq,

--------------080406090404090301060808--
