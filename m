Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVAHR1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVAHR1z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 12:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbVAHR1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 12:27:55 -0500
Received: from astro.systems.pipex.net ([62.241.163.6]:59565 "EHLO
	astro.systems.pipex.net") by vger.kernel.org with ESMTP
	id S261180AbVAHR1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 12:27:54 -0500
From: Shaheed <srhaque@iee.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] support for gzipped (ELF) core dumps
Date: Sat, 8 Jan 2005 17:27:52 +0000
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501081727.52637.srhaque@iee.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 >+/* This table is needed for efficient CRC32 calculation */
 >+static const unsigned long crc_table[8][256] = {
 >+ {
 >+ 0x00000000UL, 0x77073096UL, 0xee0e612cUL, 0x990951baUL, 0x076dc419UL,
 
First, by using "unsigned long", you may be doubling the size on most 64 bit 
platforms. Second, I'm pretty sure there is a standard implementation of 
several CRCs already in the kernel - is there a reason not to use one of them 
(e.g. a different polynomial)?
