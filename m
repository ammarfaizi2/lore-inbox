Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263841AbUDONbh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 09:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263798AbUDONb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 09:31:26 -0400
Received: from smtp.rol.ru ([194.67.21.9]:42128 "EHLO smtp.rol.ru")
	by vger.kernel.org with ESMTP id S263719AbUDONbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 09:31:22 -0400
From: Konstantin Sobolev <kos@supportwizard.com>
To: Justin Cormack <justin@street-vision.com>
Subject: Re: poor sata performance on 2.6
Date: Thu, 15 Apr 2004 17:34:03 +0400
User-Agent: KMail/1.6.1
Cc: Ryan Geoffrey Bourgeois <rgb005@latech.edu>,
       Kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
References: <200404150236.05894.kos@supportwizard.com> <200404151455.36307.kos@supportwizard.com> <1082030525.14389.70.camel@lotte.street-vision.com>
In-Reply-To: <1082030525.14389.70.camel@lotte.street-vision.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Message-Id: <200404151734.03786.kos@supportwizard.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 April 2004 16:02, Justin Cormack wrote:
> Ah I see from your config you have himem_4G turned on. How much memory
> do you have? Sii3112 appears (I dont actually have datasheets) to only
> have 32 bit DMA support, and will use bounce buffers quite a lot of the
> time if you turn on himem at all, reducing throughput substantially. Try
> again with no himem support at all and see if it helps.

I have 1.5 GB. I tried to disable highmem, now less than 1GB is visible, but 
there is no noticable difference in SATA performance:

siimage:
/dev/hde:
 setting fs readahead to 8129
 setting 32-bit IO_support flag to 1
 setting multcount to 16
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 8128 (on)
 geometry     = 16383/255/63, sectors = 145226112, start = 0
 Timing buffer-cache reads:   1428 MB in  2.00 seconds = 713.75 MB/sec
 Timing buffered disk reads:  100 MB in  3.03 seconds =  32.99 MB/sec

libata
/dev/sda:
 setting fs readahead to 8192
 readahead    = 8192 (on)
 Timing buffered disk reads:   82 MB in  3.02 seconds =  27.17 MB/sec

-- 
/KoS
* Popularity is not the same as validity. 			      
