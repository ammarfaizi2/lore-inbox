Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273819AbRJBNiT>; Tue, 2 Oct 2001 09:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273904AbRJBNiK>; Tue, 2 Oct 2001 09:38:10 -0400
Received: from sushi.toad.net ([162.33.130.105]:44754 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S273819AbRJBNh5>;
	Tue, 2 Oct 2001 09:37:57 -0400
Subject: Re: [PATCH] PnPBIOS 2.4.9-ac1[56] Vaio fix
To: linux-kernel@vger.kernel.org
Date: Tue, 2 Oct 2001 09:37:50 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20011002133751.074DA10E6@thanatos.toad.net>
From: jdthood@home.dhs.org (Thomas Hood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> However, if is_sony_vaio_laptop is 0 at pnpbios init
>> time then if you look in /proc/bus/pnp you'll see numerical
>> entries there.  
>
>Yes:
># cd /proc/bus/pnp/
># ls
>00  01  02  03  04  05  06  07  08  09  0b  0c  0d  0e  boot  devices
># ls boot
>00  01  02  03  04  05  06  07  08  09  0b  0c  0d  0e
>
>> Want to crash your machine?  Just read from
>> them.  (The numerically named entries in /proc/bus/pnp/boot 
>> should be okay to read and write, though.)
>
>It doesn't crash. I did a "cat /proc/bus/pnp/0* > /dev/null" 
>and the laptop is still alive.

Well!  That's interesting.  Reading from those files
induces the same calls to the PnP BIOS that crashed
your system before.  A mystery.  Perhaps there's a way
to use the "current" config of your PnP BIOS after all---
so long as you avoid the particular [sequences of] calls that
cause crashes.  You'll have to experiment with this yourself.

In the meantime, though, it's safest to disable use of
the "current" config entirely on Sony Vaio Laptops.  I'll
test your patch now.

-- 
Thomas Hood
(Don't reply to the From: address but to jdthood_AT_yahoo.co.uk)
