Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263290AbSKDNb2>; Mon, 4 Nov 2002 08:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264641AbSKDNb2>; Mon, 4 Nov 2002 08:31:28 -0500
Received: from hermes.domdv.de ([193.102.202.1]:44553 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S263290AbSKDNb1>;
	Mon, 4 Nov 2002 08:31:27 -0500
Message-ID: <3DC67809.30101@domdv.de>
Date: Mon, 04 Nov 2002 14:37:13 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.20rc1 compile fix for in2000.c
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070103030402020509090705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070103030402020509090705
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch fixes some section type conflict errors.
-- 
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

--------------070103030402020509090705
Content-Type: text/plain;
 name="in2000.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="in2000.c.diff"

--- ./drivers/scsi/in2000.c.orig	2002-11-04 14:15:38.000000000 +0100
+++ ./drivers/scsi/in2000.c	2002-11-04 14:18:58.000000000 +0100
@@ -1909,21 +1909,21 @@
  * special macros declared in 'asm/io.h'. We use readb() and readl()
  * when reading from the card's BIOS area in in2000_detect().
  */
-static u32 bios_tab[] in2000__INITDATA = {
+static u32 bios_tab[] = {
    0xc8000,
    0xd0000,
    0xd8000,
    0
    };
 
-static const unsigned short base_tab[] in2000__INITDATA = {
+static const unsigned short base_tab[] = {
    0x220,
    0x200,
    0x110,
    0x100,
    };
 
-static const int int_tab[] in2000__INITDATA = {
+static const int int_tab[] = {
    15,
    14,
    11,

--------------070103030402020509090705--

