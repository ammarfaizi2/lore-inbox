Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265439AbRF0WUv>; Wed, 27 Jun 2001 18:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265437AbRF0WUl>; Wed, 27 Jun 2001 18:20:41 -0400
Received: from h24-76-51-210.vf.shawcable.net ([24.76.51.210]:55026 "EHLO
	whiskey.enposte.net") by vger.kernel.org with ESMTP
	id <S265435AbRF0WUf>; Wed, 27 Jun 2001 18:20:35 -0400
To: linux-kernel@vger.kernel.org
Path: whiskey.fireplug.net!not-for-mail
From: sl@whiskey.fireplug.net (Stuart Lynne)
Newsgroups: list.linux-kernel
Subject: Re: What is the best way for multiple net_devices
Date: 27 Jun 2001 15:19:39 -0700
Organization: fireplug
Distribution: local
Message-ID: <9hdm5r$e9i$1@whiskey.enposte.net>
In-Reply-To: <993679536.14418@whiskey.enposte.net>
Reply-To: sl@fireplug.net
X-Newsreader: trn 4.0-test67 (15 July 1998)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <993679536.14418@whiskey.enposte.net>,
Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
>andrew may wrote:
>> 
>> Is there a standard way to make multiple copies of a network device?
>> 
>> For things like the bonding/ipip/ip_gre and others they seem to expect
>> insmod -o copy1 module.o
>> insmod -o copy2 module.o
>
>The network driver should provide the capability to add new devices.
>
>Most drivers currently have the capability to do N devices, where N is
>some constant set at compile time.  Typically you use ifconfig, a
>special-purpose userland program, or sometimes even sysctls to configure
>additional net devices.

Ioctls require modifications to other parts of the kernel and a supporting
user land program.

Passing the number to create via insmod seems to be a reasonable compromise.

>It's certainly possible to modify the driver to create additional
>network interfaces on the fly, but a lot of drivers are not coded to do
>that at present.

-- 
                                            __O 
Lineo - For Embedded Linux Solutions      _-\<,_ 
PGP Fingerprint: 28 E2 A0 15 99 62 9A 00 (_)/ (_) 88 EC A3 EE 2D 1C 15 68
Stuart Lynne <sl@fireplug.net>       www.fireplug.net        604-461-7532
