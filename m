Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280104AbRKIUrB>; Fri, 9 Nov 2001 15:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280107AbRKIUqm>; Fri, 9 Nov 2001 15:46:42 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:39136
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S280104AbRKIUqe>; Fri, 9 Nov 2001 15:46:34 -0500
Date: Fri, 9 Nov 2001 21:46:25 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: Compile breakage in 2415p1 in net/core
Message-ID: <20011109214625.C824@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Compiling a 2415p1 kernel with no networking support, I get the
following during make bzImage:

make[3]: Entering directory `/home/rasmus/kernel/linux-2415p1/net/core'
gcc -D__KERNEL__ -I/home/rasmus/kernel/linux-2415p1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686    -c -o sock.o sock.c
In file included from /home/rasmus/kernel/linux-2415p1/include/net/tcp.h:1036,
                 from sock.c:122:
/home/rasmus/kernel/linux-2415p1/include/net/tcp_ecn.h: In function `TCP_ECN_send':
/home/rasmus/kernel/linux-2415p1/include/net/tcp_ecn.h:54: union has no member named `af_inet'
/home/rasmus/kernel/linux-2415p1/include/net/tcp_ecn.h:61: union has no member named `af_inet'
make[3]: *** [sock.o] Error 1
make[3]: Leaving directory `/home/rasmus/kernel/linux-2415p1/net/core'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/home/rasmus/kernel/linux-2415p1/net/core'
make[1]: *** [_subdir_core] Error 2
make[1]: Leaving directory `/home/rasmus/kernel/linux-2415p1/net'
make: *** [_dir_net] Error 2

This is with CONFIG_NET unset.

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)
