Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVAMLwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVAMLwT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 06:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVAMLwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 06:52:18 -0500
Received: from mgw-x1.nokia.com ([131.228.20.21]:48528 "EHLO mgw-x1.nokia.com")
	by vger.kernel.org with ESMTP id S261602AbVAMLwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 06:52:03 -0500
X-Scanned: Thu, 13 Jan 2005 13:51:43 +0200 Nokia Message Protector V1.3.34 2004121512 - RELEASE
Subject: Re: [PATCH] support for gzipped (ELF) core dumps
From: Jan Frey <jan.frey@nokia.com>
To: ext Shaheed <srhaque@iee.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200501081727.52637.srhaque@iee.org>
References: <200501081727.52637.srhaque@iee.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Nokia-NRC/Bochum
Message-Id: <1105617091.830.27.camel@borcx178>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Thu, 13 Jan 2005 12:51:32 +0100
X-OriginalArrivalTime: 13 Jan 2005 11:51:32.0819 (UTC) FILETIME=[39FEB230:01C4F966]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried to use those "in-kernel" functions, but they seem to do little
different CRC calculations. Unfortunately I don't have any experiences
with CRC stuff, anyone able to help here?

Regards,
Jan

>  >+/* This table is needed for efficient CRC32 calculation */
>  >+static const unsigned long crc_table[8][256] = {
>  >+ {
>  >+ 0x00000000UL, 0x77073096UL, 0xee0e612cUL, 0x990951baUL, 0x076dc419UL,
>  
> First, by using "unsigned long", you may be doubling the size on most 64 bit 
> platforms. Second, I'm pretty sure there is a standard implementation of 
> several CRCs already in the kernel - is there a reason not to use one of them 
> (e.g. a different polynomial)?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
