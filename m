Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131174AbRCKAa2>; Sat, 10 Mar 2001 19:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131181AbRCKAaR>; Sat, 10 Mar 2001 19:30:17 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:45272 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S131174AbRCKAaG>;
	Sat, 10 Mar 2001 19:30:06 -0500
Message-ID: <3AAAC6C5.EF198D4A@mandrakesoft.com>
Date: Sat, 10 Mar 2001 19:28:53 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Art Boulatov <art@ksu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: filesystem for initrd
In-Reply-To: <3AAAC179.8020109@ksu.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Art Boulatov wrote:
> I'm in the process of creating a custom "system partition"
> for out Linux servers, which is actually an initial ramdisk,
> coming from hd or network on boot
> to load necessary drivers and perform important checks
> before the real filesystems get mounted,
> and I did not find any info on
> what filesystems can I use
> for initrd, are there any restrictions?
> Mostly interested in cramfs,
> due to it's compression.

Any filesystem which works with a normal block device, such as a hard
drive, will work with a ramdisk.  Read ramdisk.txt and initrd.txt in the
linux/Documentation directory, in your Linux kernel source tree.

cramfs is nice but still read-only at the moment...  You might be able
to get away with stacking ramfs on top of that.  If not, it shouldn't be
hard to modify cramfs so that it allows fs modifications... just stick
the updated pages in RAM until the file is unlinked or the fs is
unmounted.

-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
