Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286413AbSAUNnA>; Mon, 21 Jan 2002 08:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286411AbSAUNmu>; Mon, 21 Jan 2002 08:42:50 -0500
Received: from mail.loewe-komp.de ([62.156.155.230]:15122 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S286413AbSAUNmi>; Mon, 21 Jan 2002 08:42:38 -0500
Message-ID: <3C4C1A96.3504174D@loewe-komp.de>
Date: Mon, 21 Jan 2002 14:41:42 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Hannover
X-Mailer: Mozilla 4.78 [de] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Erez Doron <erez@savan.com>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: non volatile ram disk
In-Reply-To: <1011618928.2825.5.camel@hal.savan.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erez Doron schrieb:
> 
> hi
> 
> I'm looking for a way to make a ramdisk which is not erased on reboot
> this is for use with ipaq/linux.
> 
> i tought of booting with mem=32m and map a block device to the rest of
> the 32M ram i have.
> 
> the probelm is that giving mem=32m to the kernel will cause the kernel
> to map only the first 32m of physical memory to virtual one, so using
> __pa(ptr) on the top 32m causes a kernel oops.
> 
> any idea ?
> 

a MTD is the way to go, which uses the "reserved" mem area. 
I assume that the RAM is battery backed
