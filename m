Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266042AbSKFTtf>; Wed, 6 Nov 2002 14:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266043AbSKFTtf>; Wed, 6 Nov 2002 14:49:35 -0500
Received: from air-2.osdl.org ([65.172.181.6]:52155 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266042AbSKFTtd>;
	Wed, 6 Nov 2002 14:49:33 -0500
Message-Id: <200211061956.gA6Ju8B12346@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Yury Umanets <umka@namesys.com>
Cc: reiserfs-dev@namesys.com, Linux-Kernel@vger.kernel.org
Subject: Re: [reiserfs-dev] build failure: reiser4progs-0.1.0 
In-Reply-To: Your message of "Wed, 06 Nov 2002 22:14:36 +0300."
             <3DC96A1C.20805@namesys.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 06 Nov 2002 11:56:08 -0800
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Cliff White wrote:
> 
> >Attempting to test reiser4, kernel 2.5.46, using the 2002.11.05 snapshot.
> >--------------------------------------------------
> >gcc -DHAVE_CONFIG_H -I. -I. -I../.. -I../../include -g -O2 -D_REENTRANT 
> >-D_FILE_OFFSET_BITS=64 -g -W -Wall -Wno-unused -Werror 
> >-DPLUGIN_DIR=\"/usr/local/lib/reiser4\" -c alloc40.c -MT alloc40.lo -MD -MP 
> >-MF .deps/alloc40.TPlo  -fPIC -DPIC -o .libs/alloc40.lo
> >cc1: warnings being treated as errors
> >alloc40.c: In function `callback_fetch_bitmap':
> >alloc40.c:50: warning: signed and unsigned type in conditional expression
> >alloc40.c: In function `callback_flush_bitmap':
> >alloc40.c:209: warning: signed and unsigned type in conditional expression
> >alloc40.c: In function `callback_check_bitmap':
> >alloc40.c:376: warning: signed and unsigned type in conditional expression
> >make[3]: *** [alloc40.lo] Error 1
> >make[3]: Leaving directory `/root/cgl/kern/reiser/reiser4progs-0.1.0/plugin/all
> >oc40'
> >make[2]: *** [all-recursive] Error 1
> >make[2]: Leaving directory `/root/cgl/kern/reiser/reiser4progs-0.1.0/plugin'
> >make[1]: *** [all-recursive] Error 1
> >make[1]: Leaving directory `/root/cgl/kern/reiser/reiser4progs-0.1.0'
> >make: *** [all] Error 2
> >-------------------------------------
> >cliffw
> >
> >
> >
> >
> >  
> >
> You are probably using gcc-3.2. Okay, fixed. Thanks a lot for report.

No, i am not using gcc-3.2
]# gcc -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-81)
I have replicated the problem on two machines
cliffw

> 
> -- 
> Yury Umanets
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


