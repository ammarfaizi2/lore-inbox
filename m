Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314073AbSDQO3I>; Wed, 17 Apr 2002 10:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314092AbSDQO3H>; Wed, 17 Apr 2002 10:29:07 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:27396 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S314073AbSDQO3G>; Wed, 17 Apr 2002 10:29:06 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15549.34476.64714.868489@laputa.namesys.com>
Date: Wed, 17 Apr 2002 18:29:00 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Andrey Ulanov <drey@rt.mipt.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FPU, i386
In-Reply-To: <20020417140510.GB9930@gleam.rt.mipt.ru>
X-Mailer: VM 7.00 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Ulanov writes:
 > Look at this:
 > 
 > $ cat test.c
 > #include <stdio.h>
 > 
 > main()
 > {
 > 	double h = 0.2;
 > 	
 > 	if(1/h == 5.0)
 > 	    printf("1/h == 5.0\n");
 > 
 > 	if(1/h < 5.0)
 > 	    printf("1/h < 5.0\n");
 > 	return 0;
 > }
 > $ gcc test.c

$ gcc -O test.c
$ ./a.out
1/h == 5.0

without -O, gcc initializes h to 0.2000000000000000111

 > $ ./a.out
 > 1/h < 5.0
 > $ 
 > 
 > I also ran same a.out under FreeBSD. It says "1/h == 5.0".
 > It seems there is difference somewhere in FPU 
 > initialization code. And I think it should be fixed.
 > 
 > ps. cc to me
 > -- 
 > with best regards, Andrey Ulanov.
 > drey@rt.mipt.ru
