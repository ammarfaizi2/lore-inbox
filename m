Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263711AbRFGXgU>; Thu, 7 Jun 2001 19:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263723AbRFGXgK>; Thu, 7 Jun 2001 19:36:10 -0400
Received: from t2.redhat.com ([199.183.24.243]:37370 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S263711AbRFGXf4>; Thu, 7 Jun 2001 19:35:56 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.33.0106071607180.3940-100000@shell1.aracnet.com> 
In-Reply-To: <Pine.LNX.4.33.0106071607180.3940-100000@shell1.aracnet.com> 
To: Paul Buder <paulb@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Large ramdisk crashes system 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 08 Jun 2001 00:35:46 +0100
Message-ID: <14555.991956946@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


paulb@aracnet.com said:
> the kernel is 2.4.5 with 'Simple RAM-based file system support' turned on.

> I issued the following commands.

> mkfs /dev/ram0 400000
> mount /dev/ram0 /mnt
> dd if=/dev/zero of=/mnt/junk bs=1024 count=500000 

Why turn on ramfs if you're not going to use it? 

 mount -t ramfs none /mnt/junk

Use the one in the -ac tree and you get resource limits, which will be 
useful. The VM will still be broken, but you should get away with a little 
more.

--
dwmw2


