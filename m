Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264259AbRFSPE3>; Tue, 19 Jun 2001 11:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264260AbRFSPET>; Tue, 19 Jun 2001 11:04:19 -0400
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:13495 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S264259AbRFSPEJ>; Tue, 19 Jun 2001 11:04:09 -0400
Message-ID: <3B2F6A2D.A635747C@kegel.com>
Date: Tue, 19 Jun 2001 08:05:17 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "J . A . Magallon" <jamagallon@able.es>
CC: Pete Wyckoff <pw@osc.edu>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: Re: getrusage vs /proc/pid/stat?
In-Reply-To: <3B2D8ED0.40B299B5@kegel.com> <20010618134433.C9415@osc.edu> <3B2E7094.D53308BD@kegel.com> <20010619013406.A2531@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J . A . Magallon" wrote:
> I have just the same problem. getrusage() did not catch the CPU time for
> children, even if the man page said that. Now I am using times(2), that
> seems to work in Solaris, but gives nothing in Linux.
> 
> I you look at time(1) manpage, it says time is implemented over the times(2)
> system call. But if I include that call, it gives me only zero.
>
> ????? time gives good results for summed CPU time, but my own call
> to times(2) fails ???

It could be that you have to wait() for the child before times()
includes it in 'children time'.

By the way, the source for time is easy to find.  Here's debian's
(just search for time.c, then click on 'main'):
http://src.openresources.com/debian/src/utils/HTML/mains.html

If that doesn't help, maybe the code I sent you that reads /proc/pid/stat
for all threads of interest will.  Either way, let me know...
- Dan
