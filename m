Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131986AbRDFQeT>; Fri, 6 Apr 2001 12:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131990AbRDFQeK>; Fri, 6 Apr 2001 12:34:10 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:53259 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S131986AbRDFQdx>; Fri, 6 Apr 2001 12:33:53 -0400
From: Norbert Preining <preining@logic.at>
Date: Fri, 6 Apr 2001 18:33:03 +0200
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gcc oopses with 2.4.3
Message-ID: <20010406183303.A20867@alpha.logic.tuwien.ac.at>
In-Reply-To: <20010406174442.A19874@alpha.logic.tuwien.ac.at> <123100000.986572812@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <123100000.986572812@tiny>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fre, 06 Apr 2001, Chris Mason wrote:
> sigbus from gcc usually points to the ram, have you run a tester?

But sig 4 is sigill (whatever this may be) and 1ig11 sigsegv, so
no sigbus!?

BTW: The last lines of a kernel compile:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.3-ac3/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=k6    -c -o tcp_output.o tcp_output.c
gcc: Internal compiler error: program cc1 got fatal signal 11
make[3]: *** [tcp_output.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.3-ac3/net/ipv4'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.3-ac3/net/ipv4'
make[1]: *** [_subdir_ipv4] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.3-ac3/net'
make: *** [_dir_net] Error 2

Best wishes

Norbert


-- 
ciao
norb

+-------------------------------------------------------------------+
| Norbert Preining              http://www.logic.at/people/preining |
| University of Technology Vienna, Austria        preining@logic.at |
| DSA: 0x09C5B094 (RSA: 0xCF1FA165) mail subject: get [DSA|RSA]-key |
+-------------------------------------------------------------------+
