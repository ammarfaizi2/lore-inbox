Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268174AbTBND4G>; Thu, 13 Feb 2003 22:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268175AbTBND4G>; Thu, 13 Feb 2003 22:56:06 -0500
Received: from f6.pav2.hotmail.com ([64.4.37.6]:4371 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S268174AbTBND4F>;
	Thu, 13 Feb 2003 22:56:05 -0500
X-Originating-IP: [129.219.25.77]
From: "shesha bhushan" <bhushan_vadulas@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: How to Enable Hardware Checksum on Intel 82546 GBE and e1000-4.4.19 driver
Date: Fri, 14 Feb 2003 04:05:52 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F65ztVOYDWNYojnS41B00029471@hotmail.com>
X-OriginalArrivalTime: 14 Feb 2003 04:05:52.0855 (UTC) FILETIME=[5DBB4670:01C2D3DE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am attempting to simulate zerocopy on my machine and I am just learning 
kernel hacking (very naive).  I have Intel 82546 GBE and e1000-4.4.19 
drivers for it.

I have commented out the calls to  csum_and_copy_from_user() function in 
both tcp_copy_to_page and skb_add_data functions in linux/net/ipv4/tcp.c, 
which essentialy does the copy of data form the user space to kernel space 
and calulates checksum.
Can any one tell me how to enable the hardware checksumming, so that 
hardware calculates the correct checksum on the (Non relevant) data present 
in the kernel buffer and the receiveing end should think that all went fine.
In addition to setting some parameter in the driver, I think I must set some 
parameters at the tcp level so the driver realizes that checksum is not done 
in the above layers and must be don by hardware when it reseives the skbuff.

Thanking You
Shesha






_________________________________________________________________
Protect your PC - get McAfee.com VirusScan Online 
http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963

