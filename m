Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274896AbTHFHaq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 03:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274897AbTHFHaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 03:30:46 -0400
Received: from zasran.com ([198.144.206.234]:40320 "EHLO zasran.com")
	by vger.kernel.org with ESMTP id S274896AbTHFHao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 03:30:44 -0400
Message-ID: <3F30AEA3.2080007@bigfoot.com>
Date: Wed, 06 Aug 2003 00:30:43 -0700
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en-us, sk, cs, ru
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SATA HD 137GB limitation?
References: <3F1F33B0.4070701@bigfoot.com> <20030724171253.GD5695@gtf.org> <3F201AD0.1020704@bigfoot.com> <3F2D52FB.5040304@pobox.com>
In-Reply-To: <3F2D52FB.5040304@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> I just realized, 2.4 kernels don't support scsi's READ_CAPACITY_16, nor 
> 64-bit sector_t on a 32-bit processor.
> 
> Can you test Alan Cox's 2.6.0-test-ac tree?  I bet the 137GB limitation 
> may disappear there.

   thanks,

   just tried 2.6.0-test1-ac3 but it fails, is there a particular 
version that might work?

   will the READ_CAPACITY_16 and 64-bit sector_t be ported to 2.4 tree? 
or do I have to wait for usable 2.6?

   2.6.0-test1-ac3 complies OK but when installing modules there are 
number of unresolved symbols:

  INSTALL lib/zlib_deflate/zlib_deflate.ko
   INSTALL lib/zlib_inflate/zlib_inflate.ko
if [ -r System.map ]; then /sbin/depmod -ae -F System.map 
2.6.0-test1-ac3; fi
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test1-ac3/kernel/crypto/def
late.ko
depmod:         zlib_inflateInit2_
...
depmod:         zlib_deflateReset
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test1-ac3/kernel/drivers/bl
ock/paride/paride.ko
depmod:         parport_unregister_device
..depmod:         parport_find_base
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test1-ac3/kernel/drivers/ch
ar/agp/nvidia-agp.ko
depmod:         agp_remove_bridge
...
depmod:         agp_generic_alloc_by_type
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test1-ac3/kernel/drivers/ch
ar/lp.ko
depmod:         parport_read
...
depmod:         parport_release
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test1-ac3/kernel/drivers/ch
ar/ppdev.ko
depmod:         parport_read
...

   I tried to boot the kernel anyway and it fails to boot, right after 
LILO line and checking BIOS line it stars to print something so fast 
that I have no idea what it is, no keys work, only hw reset... found 
nothing relevant on lkml archives... any ideas why it fails (or which 
version would be more likely to work)?

   TIA

	erik

