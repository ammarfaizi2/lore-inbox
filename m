Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278509AbRJZQiL>; Fri, 26 Oct 2001 12:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278746AbRJZQiB>; Fri, 26 Oct 2001 12:38:01 -0400
Received: from smtppop1pub.gte.net ([206.46.170.20]:6944 "EHLO
	smtppop1pub.verizon.net") by vger.kernel.org with ESMTP
	id <S278509AbRJZQhz>; Fri, 26 Oct 2001 12:37:55 -0400
Message-ID: <3BD99233.592D297A@bellatlantic.net>
Date: Fri, 26 Oct 2001 12:41:23 -0400
From: Hong Hsu <honghsu@bellatlantic.net>
X-Mailer: Mozilla 4.75 [en] (Win95; U)
X-Accept-Language: en,zh-CN,zh-TW,zh
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Patrick Ouellet <patrick.ouellet@microtecsecurite.com>,
        Kernel Mailing lists <linux-kernel@vger.kernel.org>,
        kernelnewbies@nl.linux.org
Subject: Re: basic questions of memory management
In-Reply-To: <Pine.LNX.4.33L.0110251356150.3690-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

> On Thu, 25 Oct 2001, Patrick Ouellet wrote:
>
> > As a follower of linux for a couple of years now
> > I wanted to go deeper into the madness,
> > so I said to myself, why no go as deep as you
> > can and get yourself into the Kernel.
> >
> > My simple question is this:
> >
> > Were should I start.
>
> A good place to start would be  http://kernelnewbies.org/
> and also the kernelnewbies mailing list and IRC channel.
>
> > I would like to have a nice overview of the kernel
> > something that would help me understand all the part
> > of the kernel and how they work toghether.
>
> The book "Understanding the Linux Kernel" by O'Reilly
> is nice, also see http://kernelnewbies.org/books.php3
>
> regards,
>
> Rik

    Rik,

    I have basic questions regarding virtual address space and memory
management, wondering you can give a help.

1.   When userland process is created, how big the size of virtual
address space the kernel assign to it,  4GB or it depends on size of the
executable code?  If 4GB is used, why is that because 3GB of it will be
used excessively for the process and it is huge for most of programs.

2.  Upon the creation of a userland process, a Page Table and a Page
Directory will be created in main memory and stay there until the
process is terminated.  Besides that the /proc will have corresponding
subdirectory for the process.  Does the virtual address space has a copy
of executable code on the secondary memory, usually on hard disk, or it
just contains tables which holds addresses of  executable code?  Having
a copy of every executable code on hard disk could take a lot of space
if 3GB is used for each.

3.  If I have enough main memory,  I notice that the size of swap
(maximum is 128 MB) always zero.  Does that means no virtual address
space on hard disk?

4.  In Windows 98/ME, upon the termination of a userland process, this
portion of occupied main memory doesn't get released, instead the main
memory still hold contents of processes until page fault handler forces
it out.  Does Linux kernel use similar approach.  If so, how these
contents of processes in main memory can be reused assume same program
starts to run again as the Page Table and Page Directory are gone?

5. In your 'Memory Management Talk', you mentioned the main memory is
very slow.  As speed of Intel processor grows rapidly, speed difference
between cpu and main memory is getting big and bigger.  How the issue
could be solved in future?  Does RAM reached its limitation of speed
theoretically or L2 cache reached its limitation in terms of cost and
size?

Maybe I confuse some concepts here.   Thanks you for the help,
-Hong
honghsu@bellatlantic.net



