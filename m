Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264399AbRFSQ1J>; Tue, 19 Jun 2001 12:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264397AbRFSQ06>; Tue, 19 Jun 2001 12:26:58 -0400
Received: from pD9E16C60.dip.t-dialin.net ([217.225.108.96]:23279 "EHLO
	tolot.escape.de") by vger.kernel.org with ESMTP id <S263211AbRFSQ05>;
	Tue, 19 Jun 2001 12:26:57 -0400
Date: Tue, 19 Jun 2001 18:26:35 +0200
From: Jochen Striepe <jochen@tolot.escape.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.20-pre4
Message-ID: <20010619182635.A24252@tolot.escape.de>
In-Reply-To: <20010619172219.A18744@tolot.escape.de> <E15CNM0-00067q-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15CNM0-00067q-00@the-village.bc.nu>
User-Agent: Mutt/1.3.19i
X-Editor: vim/5.8.3
X-Signature-Color: blue
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        Hi,

On 19 Jun 2001, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > sched.c:52: conflicting types for `xtime'
> > /usr/src/linux/include/linux/sched.h:509: previous declaration of `xtime'
> 
> Stick a volatile in the declaration. Thats a real bug it found

Um...

I made it

extern volatile struct timeval xtime;

Now it stops with

/usr/src/linux/include/linux/sched.h: At top level:
/usr/src/linux/include/linux/sched.h:509: warning: useless keyword or
type name in empty declaration
In file included from /usr/src/linux/include/linux/blkdev.h:6,
                 from ksyms.c:15:
/usr/src/linux/include/linux/genhd.h: In function `ptype':
/usr/src/linux/include/linux/genhd.h:83: warning: deprecated use of
label at end of compound statement
ksyms.c: At top level:
ksyms.c:352: `xtime' undeclared here (not in a function)
ksyms.c:352: initializer element is not constant
ksyms.c:352: (near initialization for `__ksymtab_xtime.value')
make[2]: *** [ksyms.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.2.20pre4/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux-2.2.20pre4/kernel'
make: *** [_dir_kernel] Error 2


So long,

Jochen.

-- 
The number of UNIX installations has grown to 10, with more expected.
                     - Dennis Ritchie and Ken Thompson, June 1972
