Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129596AbQLDAgG>; Sun, 3 Dec 2000 19:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129700AbQLDAf4>; Sun, 3 Dec 2000 19:35:56 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:45575 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129596AbQLDAfo>; Sun, 3 Dec 2000 19:35:44 -0500
Date: Sun, 3 Dec 2000 18:01:36 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18-24 with IPVS patch has compile errors
Message-ID: <20001203180136.A24746@vger.timpanogas.org>
In-Reply-To: <20001203175226.B24652@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001203175226.B24652@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Sun, Dec 03, 2000 at 05:52:26PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2000 at 05:52:26PM -0700, Jeff V. Merkey wrote:
> 
> 
> With the 2.2.17 IPVS patch applied to 2.2.18-24, I am seeing the following
> compile errors.  
> 
>  -D__KERNEL__ -I/usr/src/ute/BUILD/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -D__SMP__ -pipe -fno-strength-reduce
> -m386 -DCPU=386 -DMODULE -DMODVERSIONS -include /usr/src/ute/BUILD/linux/include/linux/modversions.h   -c -o emd.o emd.c
> cc -D__KERNEL__ -I/usr/src/ute/BUILD/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -D__SMP__ -pipe -fno-strength-reduce
> -m386 -DCPU=386 -DMODULE -DMODVERSIONS -include /usr/src/ute/BUILD/linux/include/linux/modversions.h   -c -o check.o check.c
> cc -D__KERNEL__ -I/usr/src/ute/BUILD/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -D__SMP__ -pipe -fno-strength-reduce
> -m386 -DCPU=386 -DMODULE -DMODVERSIONS -include /usr/src/ute/BUILD/linux/include/linux/modversions.h   -c -o fsync.o fsync.c
> touch: /usr/src/ute/BUILD/linux/include/linux/sdladrv.h: No such file or directory
> make[2]: *** No rule to make target `/usr/src/ute/BUILD/linux/include/linux/sdlasfm.h', needed by `sdladrv.o'.  Stop.
> make[2]: *** Waiting for unfinished jobs....
> make[2]: *** [/usr/src/ute/BUILD/linux/include/linux/sdladrv.h] Error 1
> shell-init: could not get current directory
> job-working-directory: could not get current directory
> 
>                                                               
> The IPVS patch is also attached.  They would seem to be unrelated, but 
> 2.2.18-23 builds clean with this patch.
> 
> Jeff
> 

Update.  2.2.18-24 requires that the patch be applied to 2.2.17 before 
applying the pre-patch.  2.2.18-23 didn't seem to care about patch
order.  Got it to build with piranha after switching the patch order.

Jeff 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
