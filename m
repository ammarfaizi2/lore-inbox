Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132671AbRA0KOY>; Sat, 27 Jan 2001 05:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132668AbRA0KOP>; Sat, 27 Jan 2001 05:14:15 -0500
Received: from vp175097.reshsg.uci.edu ([128.195.175.97]:23562 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S132641AbRA0KOC>; Sat, 27 Jan 2001 05:14:02 -0500
Date: Sat, 27 Jan 2001 02:14:00 -0800
Message-Id: <200101271014.f0RAE0G04370@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: David Ford <david@linux.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/REQ] Increase kmsg buffer from 16K to 32K, kernel/printk.c
X-Newsgroups: cs.lists.linux-kernel
In-Reply-To: <cs.lists.linux-kernel/3A72804A.E6052E1B@linux.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.18 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jan 2001 08:01:14 +0000, David Ford <david@linux.com> wrote:
> Does Linus or anyone object to raising the ksmg buffer from 16K to 32K?
> 4/5 systems I have now overflow the buffer during boot before init is
> even launched.

Hmm, are you sure? man dmesg:
[...]
       -sbufsize
              use  a  buffer  of bufsize to query the kernel ring
              buffer.  This is 8196 by default (this matches  the
              default  kernel  syslog  buffer  size in 2.0.33 and
              2.1.103).  If you have set  the  kernel  buffer  to
              larger  than  the  default  then this option can be
              used to view the entire buffer.

So try dmesg -s 16384. That's good enough for me on a 4-way SMP
box with lots of SCSI on-board (and trust me, SMP generates a *huge*
amount of kernel logging).


Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
