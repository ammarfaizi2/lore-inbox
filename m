Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263398AbTGTIIB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 04:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263407AbTGTIIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 04:08:00 -0400
Received: from mail.gmx.de ([213.165.64.20]:2008 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263398AbTGTIHp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 04:07:45 -0400
Subject: Re: 2.6.0-test1 cryptoloop & aes
From: Benjamin Weber <shawk@gmx.net>
To: hcb@unco.de
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1058689357.4241.9.camel@athxp.bwlinux.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 20 Jul 2003 10:22:37 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christian

I think you need to write 

losetup -e aes128 /dev/loop5 /dev/hda4 or
losetup -e aes256 /dev/loop5 /dev/hda4 

instead of just
losetup -e aes /dev/loop5 /dev/hda4

If you have use for a good howto that deals with an aes cryptoloop setup
(not kernel based though) , check this one:
http://forums.gentoo.org/viewtopic.php?t=31363&start=0

--
Benjamin


> Hello, 
> 
> 
> i try to test the cryptoloop in 2.6.0-test1. I have enabled: 
> 
> 
> CONFIG_BLK_DEV_LOOP=y 
> CONFIG_BLK_DEV_CRYPTOLOOP=y 
> CONFIG_CRYPTO=y 
> CONFIG_CRYPTO_HMAC=y 
> CONFIG_CRYPTO_AES=y 
> 
> 
> Then i installed the losetup from util-linux-2.12pre. When i setup 
> the device like this: 
> 
> 
> /lib/losetup -e aes /dev/loop5 /dev/hda4 
> 
> 
> I get: 
> 
> 
> Unsupported encryption type aes 
> 
> 
> cat /proc/crypto: 
> 
> 
> name : aes 
> module : kernel 
> blocksize : 16 
> min keysize : 16 
> max keysize : 32 
> ivsize : 16 
> 
> 
> Is the cryptoloop in 2.6.0 not usable yet? 
> 
> 
> Regards, 
>  Christian 
> 
> 



