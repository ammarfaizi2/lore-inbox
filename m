Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWAYJ7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWAYJ7l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 04:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbWAYJ7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 04:59:41 -0500
Received: from uproxy.gmail.com ([66.249.92.206]:21022 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751099AbWAYJ7l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 04:59:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=V0wVLIGqBXca+OjFlHtdmmHFVgRb8Zx+bN/N223OvCkpqkTjHdDnknr6jLgd2lP/cgpcSgdc+Q4nvmTSCosZAb5GZu0YNM2w273pbITC0puD06c+ik25iXBdnNfN0Qu0M75Vg6HqPiCGLkrPeVAuBm7Cor45vg3Q+N/bK7MMtN4=
Message-ID: <8e8498350601250159w126f0f37k@mail.gmail.com>
Date: Wed, 25 Jan 2006 18:59:39 +0900
From: Tetsuo Takata <takatan.linux@gmail.com>
To: akpm@osdl.org, axboe@suse.de
Subject: [PATCH]scsi:removal of the variable "ordered_flush"
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_30341_7039302.1138183179826"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_30341_7039302.1138183179826
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Content-Disposition: inline

SGksCgoKQWZ0ZXIgdGhlIHJlY2VudCBvdmVyaGF1bCBvZiB0aGUgYmxvY2sgbGF5ZXIgdGhlIHZh
cmlhYmxlCiJvcmRlcmVkX2ZsdXNoIiBpcyBubyBsb25nZXIgdXNlZC4KCgpSZWdhcmRzLAoKVGV0
c3VvIFRha2F0YQo=
------=_Part_30341_7039302.1138183179826
Content-Type: application/octet-stream; name=remove_ordered_flush.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="remove_ordered_flush.patch"

The patch below removes dead code.

Signed-off-by: Tetsuo Takata <takatatt@intellilink.co.jp>
---

diff -urNp linux-2.6.16-rc1-git4/include/scsi/scsi_host.h linux-2.6.16-rc1-git4-fixed/include/scsi/scsi_host.h
--- linux-2.6.16-rc1-git4/include/scsi/scsi_host.h	2006-01-23 21:29:17.000000000 +0900
+++ linux-2.6.16-rc1-git4-fixed/include/scsi/scsi_host.h	2006-01-25 18:11:59.000000000 +0900
@@ -554,7 +554,6 @@ struct Scsi_Host {
 	/*
 	 * ordered write support
 	 */
-	unsigned ordered_flush:1;
 	unsigned ordered_tag:1;
 
 	/*

------=_Part_30341_7039302.1138183179826--
