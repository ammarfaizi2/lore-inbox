Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422956AbWBOEwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422956AbWBOEwy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 23:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422957AbWBOEwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 23:52:54 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:64920 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1422956AbWBOEwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 23:52:53 -0500
Subject: Re: 2.6.15.x - very slow disk-writing
From: Lee Revell <rlrevell@joe-job.com>
To: "Nikolay N. Ivanov" <nn@nndl.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <43F2D3A3.9030707@nndl.org>
References: <43F0F67A.8080001@nndl.org>
	 <20060213200517.20f7a291.akpm@osdl.org>	<43F2BEE5.5060002@nndl.org>
	 <20060214193121.752767ee.akpm@osdl.org>  <43F2D3A3.9030707@nndl.org>
Content-Type: text/plain
Date: Tue, 14 Feb 2006 23:52:45 -0500
Message-Id: <1139979166.2733.17.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-15 at 07:09 +0000, Nikolay N. Ivanov wrote:
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> Probing IDE interface ide0...
> hda: SAMSUNG SP0411N, ATA DISK drive
> Probing IDE interface ide1...
> hdc: ASUS CB-5216A, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15


> /dev/hda:
>   multcount    = 16 (on)
>   IO_support   =  0 (default 16-bit)
>   unmaskirq    =  0 (off)
>   using_dma    =  0 (off)

It looks like you are using the generic IDE driver, rather than the one
for your chipset, and it is not enabling DMA?

Lee

