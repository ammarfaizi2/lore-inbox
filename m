Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265477AbTAJQ4B>; Fri, 10 Jan 2003 11:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265480AbTAJQ4B>; Fri, 10 Jan 2003 11:56:01 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:35140 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id <S265475AbTAJQz7>; Fri, 10 Jan 2003 11:55:59 -0500
Message-ID: <3E1EFD27.5010008@google.com>
Date: Fri, 10 Jan 2003 09:04:39 -0800
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.4.21-pre3] BUG: IDE DMA doesn't work w/ x86 HighMem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Configure the 2.4.21-pre3 kernel with IDE and Highmem and when DMA is 
attempted you get a BUG from asm-i386/pci.h line 155 called from 
drives/ide/ide-dma.c line 282.  

 From the looks of it, the IDE driver has not been highmem enabled, but 
does get a high-mem device queue.  

This is easily reproduced on a dual proc P3 with 2 Gigs of ram.

    Ross


