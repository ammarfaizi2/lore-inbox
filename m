Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265414AbTAJQNr>; Fri, 10 Jan 2003 11:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265423AbTAJQNr>; Fri, 10 Jan 2003 11:13:47 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:52114
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265414AbTAJQNr>; Fri, 10 Jan 2003 11:13:47 -0500
Subject: Re: BLKBSZSET still not working on 2.4.18 ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ludovic Drolez <ludovic.drolez@freealter.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E1EE7A3.1050401@freealter.com>
References: <3E1EE7A3.1050401@freealter.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042218525.31848.40.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 10 Jan 2003 17:08:46 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-10 at 15:32, Ludovic Drolez wrote:
> I'm trying to backup a partition on an IDE drive which has an odd number 
> of sectors (204939). With a stock open/read you cannot access the last 
> sector, and that why I tried the BLKBSZSET ioctl to set the basic read 
> block size to 512 bytes. I verified the writen value with BLKBSZGET 
> ioctl, but I still cannot read this last sector !

Its a known 2.4 limitation. The last odd sector isnt normally used by
anything so it has never been a big issue (except with EFI partition
data). There is a patch to allow the last sector to be recovered but
its quite ugly so never went mainstream.


