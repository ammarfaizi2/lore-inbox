Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130436AbRCGIt2>; Wed, 7 Mar 2001 03:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130437AbRCGItI>; Wed, 7 Mar 2001 03:49:08 -0500
Received: from www.wen-online.de ([212.223.88.39]:29452 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130436AbRCGItD>;
	Wed, 7 Mar 2001 03:49:03 -0500
Date: Wed, 7 Mar 2001 09:47:59 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Vibol Hou <vhou@khmer.cc>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>, <andrewm@uow.edu.au>,
        <balbir@reflexnet.net>, <hahn@coffee.psychology.mcmaster.ca>
Subject: Re: System slowdown on 2.4.2-ac5 (recurring from 2.4.1-ac20 and
 2.4.0)
In-Reply-To: <NDBBKKONDOBLNCIOPCGHAEAEFDAA.vhou@khmer.cc>
Message-ID: <Pine.LNX.4.33.0103070939011.1305-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Mar 2001, Vibol Hou wrote:

> Hi,
>
> This is a follow up report on a server I run which is now using 2.4.2-ac5.
> It was suggested that the problem might be a NIC driver issue, but that
> seems unlikely at this point.
>
> You can find my previous posts at the following links to get a better idea
> of what I am encountering:
>
> http://www.uwsg.indiana.edu/hypermail/linux/kernel/0101.3/0470.html
> http://www.uwsg.indiana.edu/hypermail/linux/kernel/0102.3/0401.html
>
> The problem still persists with the new 2.4.2-ac5 kernel, and I have a
> feeling it has to do with the VM subsystem.  The system runs Apache, MySQL,
> and Sendmail.  It has ~900MB RAM.  The first lockup in 2.4.2-ac5 occured

Hi,

This portion of your log...

httpd     S 7FFFFFFF  3700 15058   1684        (NOTLB)   15061 15055
Call Trace: [<IN MWaI tcWahtdochg do[] <ce01ted9c9t2edd> L] OC[K<UPc0 o1ndb
1CPadU0>],  re[<gic0st1e1r3bsf:
8>] C[<c<c001f1f2f2afa66>>]]  [ <  c0 01c013f05:[5<>]c 010[<7ec0411>c4]3
8d>EF] LA
GS:  0  00  00 0 8[7
<c0 eac0x:2 8ac042208a[>]<c 0 13 e32bxd3: >]ce 8[4a<c00010 26  e6ec0>x:]
f7[<94ce0013803 43  5>ed]x : [0<0c00010008e00c
b>] e
i:dht  tp  d   0 0     Se dDi:7 A4ce3F8428a0 00       0eb 1p:5 0c601 28 a
412680 4    es  p:    ce8 (4NbeOTfLc
B) ds: 0018   es: 0018   ss: 0018

...leads me to believe that the NMI-Watchdog fired.  (I think that points
the finger away from VM, but..)  It looks like it's saying that a lock
of cpu 0 was detected if I squint at it right.  It's too munged to tell.

	-Mike

