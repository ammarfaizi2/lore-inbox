Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266626AbUGPVrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266626AbUGPVrZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 17:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266632AbUGPVrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 17:47:25 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:48568 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266626AbUGPVrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 17:47:21 -0400
Date: Fri, 16 Jul 2004 14:47:21 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: "Amit D. Chaudhary" <amit_c@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MAX_DMA_ADDRESS in include/asm/asm-i386/dma.h (2.6.x and 2.4.x)
Message-ID: <20040716214721.GA20741@plexity.net>
Reply-To: dsaxena@plexity.net
References: <40F84A87.5050403@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F84A87.5050403@comcast.net>
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 16 2004, at 14:37, Amit D. Chaudhary was caught saying:
> While writing some DMA page gathering code, I realize that 
> __get_free_page or kmalloc does not return memory more than 16 MB 
> (typically around 11-12 MB even if it done right after a reboot.)
> 
> Since this is for a PCI device (A Fibre channel HBA), I remembered that 
> the book Linux Device Driver, edition 2 mentions that the 16 MB limit is 
> for DMA with ISA devices, while PCI DMA can access upto 950 MB or so, 
> using 32 bit addresses.

Using __get_free_page() or kmalloc() for device DMA'ble descriptors (I am
guessing that's what you are doing) is wrong. See Documentation/DMA-API.txt
and Documentation/DMA-mapping.txt for the proper way to do this. 

~Deepak

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and
 will die here like rotten cabbages." - Number 6
