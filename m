Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266165AbUA2CZU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 21:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266166AbUA2CZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 21:25:20 -0500
Received: from user-119ahgg.biz.mindspring.com ([66.149.70.16]:52409 "EHLO
	mail.home") by vger.kernel.org with ESMTP id S266165AbUA2CZQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 21:25:16 -0500
From: Eric <eric@cisu.net>
To: Greg Stark <gsstark@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: Can't enable DMA on my DVD in 2.6.1?
Date: Wed, 28 Jan 2004 20:24:19 -0600
User-Agent: KMail/1.5.94
References: <873cae17pi.fsf@stark.xeocode.com>
In-Reply-To: <873cae17pi.fsf@stark.xeocode.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401282024.19658.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> /dev/hdd:
>  setting using_dma to 1 (on)
>  HDIO_SET_DMA failed: Operation not permitted
>  using_dma    =  0 (off)
>

-EPERM is usually caused by not having your chipset compiled into the kernel 
or the chipset driver not supporting DMA. 
	If the first is the case, try compiling in one or more chipsets you suspect 
are yours in Device Drivers->Char->(ALI Chipset support, ATI Chipset support 
etc.) and Device Drivers->ATA/ATAPI->(ALI Chipset support, AMD Chipset 
support) etc. etc. Find your chipsets and compile them into the kernel.
	If its the second case I have no idea if a particular driver isnt supporting 
DMA. AFAIK they all should. Thats a question for that particular chipset 
maintainer.
	However your problem is most certainly the first. It escapes me which device 
section will solve your problem (CHAR or ATA/ATAPI) but try both, it won't 
hurt to have some un-used code in the kernel. You can always remove un-needed 
drivers when you pinpoint the driver you need.
-------------------------
Eric Bambach
Eric at cisu dot net
-------------------------
