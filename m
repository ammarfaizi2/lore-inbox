Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314083AbSDQOFi>; Wed, 17 Apr 2002 10:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314086AbSDQOFh>; Wed, 17 Apr 2002 10:05:37 -0400
Received: from frtk-campus-gw.mipt.ru ([194.85.82.97]:46600 "EHLO
	frtk-campus-gw.mipt.ru") by vger.kernel.org with ESMTP
	id <S314083AbSDQOFh>; Wed, 17 Apr 2002 10:05:37 -0400
Date: Wed, 17 Apr 2002 18:05:10 +0400
From: Andrey Ulanov <drey@rt.mipt.ru>
To: linux-kernel@vger.kernel.org
Subject: FPU, i386
Message-ID: <20020417140510.GB9930@gleam.rt.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Look at this:

$ cat test.c
#include <stdio.h>

main()
{
	double h = 0.2;
	
	if(1/h == 5.0)
	    printf("1/h == 5.0\n");

	if(1/h < 5.0)
	    printf("1/h < 5.0\n");
	return 0;
}
$ gcc test.c
$ ./a.out
1/h < 5.0
$ 

I also ran same a.out under FreeBSD. It says "1/h == 5.0".
It seems there is difference somewhere in FPU 
initialization code. And I think it should be fixed.

ps. cc to me
-- 
with best regards, Andrey Ulanov.
drey@rt.mipt.ru
