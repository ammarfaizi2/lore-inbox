Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbQLXBOR>; Sat, 23 Dec 2000 20:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131039AbQLXBN5>; Sat, 23 Dec 2000 20:13:57 -0500
Received: from mail-4.tiscalinet.it ([195.130.225.150]:52869 "EHLO
	mail.tiscalinet.it") by vger.kernel.org with ESMTP
	id <S129595AbQLXBNy>; Sat, 23 Dec 2000 20:13:54 -0500
Message-ID: <3A4546B8.DA532EA4@tiscalinet.it>
Date: Sun, 24 Dec 2000 01:43:36 +0100
From: Fabrizio Gennari <fabrizio.ge@tiscalinet.it>
X-Mailer: Mozilla 4.5 [it] (Win98; I)
X-Accept-Language: it
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Trouble when linking aic7xxx.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having trouble when biulding the 2.2.18 Linux kernel (on a Redhat
7.0, gcc-2.96). At link-time, the linker complains that in the file
aic7xxx.o, in the function aic7xxx_load_seeprom, there is an "undefined
reference to 'memcpy'". In fact, doing 'nm aic7xxx.o' gives a 'U
memcpy', but, strangely enough, there is no explicit reference to memcpy
in the function! Commenting out the whole function will make the 'U
memcpy' symbol disappear from aic7xxx.o (but obviously would give a
broken kernel)

What could be the cause? I can send the configuration file made by 'make
menuconfig', if needed.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
