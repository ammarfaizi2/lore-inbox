Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266328AbUGOU7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266328AbUGOU7v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 16:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266337AbUGOU7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 16:59:50 -0400
Received: from 209-128-98-078.BAYAREA.NET ([209.128.98.78]:47744 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S266328AbUGOU7t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 16:59:49 -0400
Message-ID: <40F6F00E.4030400@zytor.com>
Date: Thu, 15 Jul 2004 13:58:54 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Schumacher <matt.s@aptalaska.net>
CC: Tim Bird <tim.bird@am.sony.com>, linux-kernel@vger.kernel.org,
       syslinux@zytor.com
Subject: Re: Possible bug with kernel decompressor.
References: <40F490B6.6000106@schu.net> <40F5AE63.5010505@am.sony.com> <40F6C504.9010403@aptalaska.net> <40F6DD54.5040308@zytor.com> <40F6EBC6.7060205@aptalaska.net>
In-Reply-To: <40F6EBC6.7060205@aptalaska.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Schumacher wrote:
> 
> This is what I was using in syslinux that broke with "invalid compressed 
> format (err=2)" after a improper shutdown (only ramdisk mounted).
> 
>  LABEL linux
>   KERNEL linux26
>   APPEND memmap=exactmap memmap=640K@0 memmap=63M@1M 
> console=ttyS0,9600n8 load_ramdisk=1 initrd=rootfs.gz root=/dev/root 
> ramdisk_size=32768 ether=9,0x320,0,0x3c509,eth0 
> ether=10,0x330,0,0x3c509,eth1 ide0=ali14xx
> 

What happens if you specify mem=64M, which should be the exact equivalent to 
the above?

	-hpa

