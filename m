Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264641AbSKDNbf>; Mon, 4 Nov 2002 08:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264649AbSKDNbe>; Mon, 4 Nov 2002 08:31:34 -0500
Received: from hermes.domdv.de ([193.102.202.1]:44809 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S264641AbSKDNbd>;
	Mon, 4 Nov 2002 08:31:33 -0500
Message-ID: <3DC67810.9010704@domdv.de>
Date: Mon, 04 Nov 2002 14:37:20 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.20rc1 compile fix for t128.c
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070508090505080007010908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070508090505080007010908
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch fixes a section type conflict error.
-- 
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

--------------070508090505080007010908
Content-Type: text/plain;
 name="t128.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="t128.c.diff"

--- ./drivers/scsi/t128.c.orig	2002-11-04 14:21:30.000000000 +0100
+++ ./drivers/scsi/t128.c	2002-11-04 14:21:47.000000000 +0100
@@ -145,7 +145,7 @@
 static const struct signature {
 	const char *string;
 	int offset;
-} signatures[] __initdata = {
+} signatures[] = {
 	{"TSROM: SCSI BIOS, Version 1.12", 0x36},
 };
 

--------------070508090505080007010908--

