Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132532AbQKXKIS>; Fri, 24 Nov 2000 05:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132608AbQKXKII>; Fri, 24 Nov 2000 05:08:08 -0500
Received: from vp175103.reshsg.uci.edu ([128.195.175.103]:64772 "EHLO
        moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
        id <S132532AbQKXKH6>; Fri, 24 Nov 2000 05:07:58 -0500
Date: Fri, 24 Nov 2000 01:37:50 -0800
Message-Id: <200011240937.eAO9bo102035@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: gcc-2.95.2-51 is buggy
In-Reply-To: <UTC200011240520.GAA143373.aeb@aak.cwi.nl>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.18pre23 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2000 06:20:33 +0100 (MET), Andries.Brouwer@cwi.nl wrote:

> Reading specs from /usr/lib/gcc-lib/i486-suse-linux/2.95.2/specs
> gcc version 2.95.2 19991024 (release)
> % /usr/bin/gcc -Wall -O2 -o bug bug.c; ./bug
> 0x84800000
> % /usr/gcc/aeb/bin/gcc -v
> Reading specs from /usr/gcc/aeb/lib/gcc-lib/i686-pc-linux-gnu/2.95.2/specs
> gcc version 2.95.2 19991024 (release)
> % /usr/gcc/aeb/bin/gcc -Wall -O2 -o nobug bug.c; ./nobug
> 0x0
> 
> So, not all versions of gcc 2.95.2 are equal.

Interesting. Plain vanilla 2.95.2 from ftp.gnu.org exhibits the same
bug on an BSDI2.1 i386 system.

defiant ~/tmp$ gcc -v
Reading specs from /usr/local/gnu/lib/gcc-lib/i386-pc-bsdi2.1/2.95.2/specs
gcc version 2.95.2 19991024 (release)
defiant ~/tmp$ gcc -O2 -o bug bug.c; ./bug
0x4800000

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
