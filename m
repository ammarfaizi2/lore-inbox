Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262699AbUKEON1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262699AbUKEON1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 09:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262697AbUKEON0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 09:13:26 -0500
Received: from mail-red.bigfish.com ([216.148.222.61]:10461 "EHLO
	mail16-red-R.bigfish.com") by vger.kernel.org with ESMTP
	id S262700AbUKEOKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 09:10:42 -0500
X-BigFish: VPC
Subject: non_linear memory on ARM
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.arm.linux.org.uk
X-Mailer: Lotus Notes Release 5.0.10  March 22, 2002
Message-ID: <OFC878058C.F34D3F6A-ONC1256F43.004C88F3-C1256F43.004DDB20@nice.mindspeed.com>
From: remy.gauguey@mindspeed.com
Date: Fri, 5 Nov 2004 15:10:12 +0100
MIME-Version: 1.0
X-MIMETrack: Serialize by Router on SOPHIAM1/Server/Mindspeed(Release 5.0.12  |February
 13, 2003) at 11/05/2004 03:10:22 PM,
	Itemize by SMTP Server on NPBLNH1/Server/Conexant(Release 5.0.12  |February
 13, 2003) at 11/05/2004 06:10:22 AM,
	Serialize by Router on NPBLNH1/Server/Conexant(Release 5.0.12  |February 13, 2003) at
 11/05/2004 06:10:24 AM,
	Serialize complete at 11/05/2004 06:10:24 AM
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Hello,

I'm currently working on a ARM920 platform with 2 SDRAM controllers on 2
separate AHB bus layers.
To improve performances (data routing) I would like the kernel to use those
2 SDRAM controllers.
Unfortunnately, there's a big gap between them :
The first SDRAM is mapped at (physical) 0x00000000 to 0x07FFFFFF (128Mb).
The second SDRAM is mapped at 0xA0000000 to 0xA7FFFFFF (128Mb).

I've tried to use the CONFIG_DISCONTIGMEM, but it seems that the large gap
of 2,5 Gb is a problem.
I've read about a patch  CONFIG_NONLINEAR which perhaps could be helpfull
in case of sparse memory.

Is this patch available for ARM ?
If not, is there any other way to efficiently use those 2 SDRAM
controllers.

The ultimate goal would be to allocate data buffer (skb) on one controller
while running code from the other one....

Thanks for any usefull feedback.

Remy




