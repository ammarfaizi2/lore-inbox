Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280201AbRKSHS0>; Mon, 19 Nov 2001 02:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280191AbRKSHSP>; Mon, 19 Nov 2001 02:18:15 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:47592 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S280201AbRKSHSC>;
	Mon, 19 Nov 2001 02:18:02 -0500
Date: Mon, 19 Nov 2001 02:17:59 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: more fun with procfs (netfilter)
In-Reply-To: <Pine.GSO.4.21.0111190156140.17210-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0111190215390.17210-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> BTW, from strace output in cpuinfo bug report SuSE bash does reads by 128
> bytes.  Which means that while read i; do echo $i; done </proc/net/ip_conntrack
> will come out empty (lots of lines are longer than 160 characters).

PS: with bash-2.03:
$ while read i; do echo $i; done < /proc/ip_tables_names
$ while read i; do echo $i; done < /proc/ip_conntrack
$
'cause this beast reads byte-by-byte...

