Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293555AbSBZJpG>; Tue, 26 Feb 2002 04:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293556AbSBZJo4>; Tue, 26 Feb 2002 04:44:56 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:25040 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP
	id <S293555AbSBZJoj>; Tue, 26 Feb 2002 04:44:39 -0500
Date: Tue, 26 Feb 2002 04:43:23 -0500
From: Skip Ford <skip.ford@verizon.net>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: drivers/block/rd.c compile error
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200202260841.g1Q8fWv03208@mailgate5.cinetic.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200202260841.g1Q8fWv03208@mailgate5.cinetic.de>; from ch.nolte@web.de on Tue, Feb 26, 2002 at 09:41:36AM +0100
Message-Id: <20020226094438.ROAR21100.out010.verizon.net@pool-141-150-235-204.delv.east.verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ch.nolte@web.de wrote:
> 
> I think I`ve found a problem with the Linux-Sources 2.5.5. I have compiled
> the code on two different systems, this is what happened:
> 
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.5.5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /usr/src/linux-2.5.5/include/linux/modversions.h  -DKBUILD_BASENAME=rd  -c -o rd.o rd.c
> rd.c: In function `rd_make_request':
> rd.c:271: too many arguments to function
> make[2]: *** [rd.o] Error 1
> make[2]: Leaving directory `/usr/src/linux-2.5.5/drivers/block'
> make[1]: *** [_modsubdir_block] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.5.5/drivers'
> make: *** [_mod_drivers] Error 2
> 
> # cat drivers/block/rd.c -n |grep bi_end_io
>    271          sbh->bi_end_io(sbh, len >> 9);
                                    ^^^^^^^^^^

Delete the second parameter in the call and it will work fine.

- -- 
Skip
