Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262628AbVA0Ok0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262628AbVA0Ok0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 09:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbVA0Ok0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 09:40:26 -0500
Received: from host-216-252-217-242.interpacket.net ([216.252.217.242]:63743
	"EHLO forof.hylink.am") by vger.kernel.org with ESMTP
	id S262628AbVA0OkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 09:40:21 -0500
Message-ID: <006b01c5047e$1efc78a0$1000000a@araavanesyan>
From: "Ara Avanesyan" <araav@hylink.am>
To: <linux-kernel@vger.kernel.org>
Subject: ixdp4xx restart. watchdog enable value
Date: Thu, 27 Jan 2005 18:40:17 +0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.0
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in file: include/asm-arm/arch-ixp4x//system.h
function: arch_reset

code snap --
/* disable watchdog interrupt, enable reset, enable count */
*IXP4XX_OSWE = 0x3;
--

according to intel's documentation the appropriate bits are in the
following order:
bit 2: wdog_cnt_ena
bit 1: wdog_int_ena
bit 0: wdog_rst_ena

so the above assigned value should be 101b == 0x5.
I do not know why 0x3 works at all. Btw, u-boot assigns 0x5.

This is for all kernels I had a chance to look at (2.4.20-2.6.10).

__
Thanks,
Ara

