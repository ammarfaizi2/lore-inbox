Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272619AbTHSSB1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 14:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272612AbTHSSAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 14:00:15 -0400
Received: from foo209.internut.com ([209.181.68.209]:15781 "EHLO bartman")
	by vger.kernel.org with ESMTP id S272432AbTHSR4Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 13:56:24 -0400
From: "Chuck Luciano" <chuck@mrluciano.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: redhat 2.4.20 kernel 3.5G patch, bug report on my previous 2.4.18 kernel 3.5G patch
Date: Tue, 19 Aug 2003 11:55:00 -0600
Message-ID: <NFBBKNADOLMJPCENHEALCENAGLAA.chuck@mrluciano.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Again, I've been kinda lazy about adding the configuration stuff, but, this patch applied to kernel-2.4.20-18.7.src.rpm will give
you a kernel where PAGE_OFFSET can be set with 2 MB granularity instead of 1GB.

BTW, there is a defect in the 2.4.18 version of this patch in the function get_pgd_slow which doesn't handle the partial PGD
properly. In 2.4.20 the fix for this problem is in the function pgd_alloc. I will probably not have time to back port this fix to
2.4.18.

Anyway, for your fun and amusement, the 2.4.20 patch is working and ready for use. I haven't tried seeing just how far I can push
PAGE_OFFSET yet, but I'd like to see how close I can get to 0xf0000000 and maybe beyond.

Links:

http://www.mrluciano.com/chuck/linux-2.4.18-unaligned.patch
http://www.mrluciano.com/chuck/linux-2.4.20-unaligned.patch
Chuck Luciano

chuck@mrluciano.com

