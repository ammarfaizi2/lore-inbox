Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314505AbSESP5v>; Sun, 19 May 2002 11:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314512AbSESP5t>; Sun, 19 May 2002 11:57:49 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:34322 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S314505AbSESP5V>; Sun, 19 May 2002 11:57:21 -0400
Date: Sun, 19 May 2002 17:57:14 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: David Eduardo Gomez Noguera <davidgn@servidor.unam.mx>
Cc: kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with swap partition.
Message-ID: <20020519155714.GA25044@louise.pinerecords.com>
In-Reply-To: <1021824299.2430.7.camel@hikaru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: Linux/sparc 2.2.21-rc4-ext3-0.0.7a SMP (up 3 days, 9:15)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Disk /dev/hdc: 16 heads, 63 sectors, 77545 cylinders
> 
> Nr AF  Hd Sec  Cyl  Hd Sec  Cyl    Start     Size ID
>  1 00   1   1    0  15  63   65       63    66465 83
>  2 00   0   1   66  15  63 1023    66528 77952672 83
>  3 00  15  63 1023  15  63 1023 78019200   146160 82
>  4 00   0   0    0   0   0    0        0        0 00
> 
> The 3'rd partition is a Linux Swap,
> /dev/hdc3         77401     77545     73080   82  Linux swap
> 
> but swapon -a gives
> swapon: /dev/hdc5: Invalid argument


$ vi /etc/fstab
(change 'hdc5' to 'hdc3'.)
$ mkswap /dev/hdc3 && swapon -a

and then please
$ man 5 fstab
