Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143524AbRA1Qua>; Sun, 28 Jan 2001 11:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143532AbRA1QuV>; Sun, 28 Jan 2001 11:50:21 -0500
Received: from mserv1a.vianw.co.uk ([195.102.240.34]:33698 "EHLO
	mserv1a.vianw.co.uk") by vger.kernel.org with ESMTP
	id <S143524AbRA1QuF>; Sun, 28 Jan 2001 11:50:05 -0500
From: Alan Chandler <alan@chandlerfamily.org.uk>
To: linux-kernel@vger.kernel.org
Subject: compile error in 2.4.0
Date: Sun, 28 Jan 2001 16:49:45 +0000
Organization: [private individual]
Message-ID: <36j87tctr3nfujoqkes8360061284rtg9b@4ax.com>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm probably doing something silly, but I have just tried to rebuild
the 2.4.0 kernel.  I changed a few config things and did

make dep clean bzlilo modules modules_install

and the following appeared.  I did a brief look around for the
declaration of skb_datarefp but couldn't find it. 


make[3]: Entering directory `/usr/src/linux/net/core'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -
fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686
-malign-functions=4     -c
-o sock.o sock.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -
fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686
-malign-functions=4     -c
-o skbuff.o skbuff.c
skbuff.c: In function `alloc_skb':
skbuff.c:208: warning: implicit declaration of function `skb_datarefp'
skbuff.c:208: invalid type argument of `->'
skbuff.c: In function `kfree_skbmem':
skbuff.c:257: warning: passing arg 1 of `atomic_dec_and_test' makes
pointer from integer witho
ut a cast
skbuff.c: In function `skb_clone':
skbuff.c:321: warning: passing arg 1 of `atomic_inc' makes pointer
from integer without a cast
make[3]: *** [skbuff.o] Error 1
make[3]: Leaving directory `/usr/src/linux/net/core'
Alan

alan@chandlerfamily.org.uk
http://www.chandler.u-net.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
