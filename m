Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286521AbSBIT5x>; Sat, 9 Feb 2002 14:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285424AbSBIT5o>; Sat, 9 Feb 2002 14:57:44 -0500
Received: from mail.cogenit.fr ([195.68.53.173]:33950 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S286521AbSBIT5j>;
	Sat, 9 Feb 2002 14:57:39 -0500
Date: Sat, 9 Feb 2002 20:57:34 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: "Peter H. R?egg" <pruegg@eproduction.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with mke2fs on huge RAID-partition
Message-ID: <20020209205734.A17825@fafner.intra.cogenit.fr>
In-Reply-To: <3C640C90.E71E3F70@eproduction.ch> <E16ZFbD-0004TM-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16ZFbD-0004TM-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Feb 08, 2002 at 06:18:15PM +0000
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> :
[...]
> The limit is about 1Tb currently. You are hitting something else, perhaps
> a driver or VM problem ?

Promise driver + 2.4.17, see:
Message-ID: <20020108003953.A16356@fafner.intra.cogenit.fr>
Message-ID: <20020119230852.A18674@se1.cogenit.fr>

                 | Intel | Promise
-----------------+-------+--------
raid1 creation   |  fast |  fast
dd of=filesystem |  fast |  slow (*)

mkfs doesn't behaves too badly but it did when I first tried to raid1 the 
whole disks.

Raid1 is software only.
As soon as a filesystem on the promise adapter comes into play, writes maxes 
out at 2,5Mo/s. The previous machine (old PA2012 motherboard) with 8 times 
less memory was able to stand 4~5Mo/s with vanilla broken kernel.
Now it's running 2.4.18-pre3-ac2 but the behavior is the same with vanilla
pre, vanilla + akpm ll, +ide patches. Feel free to ask if you want a test on a
specific version. I have dedicated a partition on each disk for testing.

-- 
Ueimor
