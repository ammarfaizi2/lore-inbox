Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279506AbRKIG53>; Fri, 9 Nov 2001 01:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279509AbRKIG5T>; Fri, 9 Nov 2001 01:57:19 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:11525 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S279506AbRKIG5B>; Fri, 9 Nov 2001 01:57:01 -0500
Message-ID: <3BEB7CF2.AC027782@zip.com.au>
Date: Thu, 08 Nov 2001 22:51:30 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Lowery <Robert.Lowery@colorbus.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Assertion failure wth ext3 on standard Redhat 7.2 kernel
In-Reply-To: <370747DEFD89D2119AFD00C0F017E66150B29A@cbus613-server4.colorbus.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Lowery wrote:
> 
> Hi,
> 
> I have recently upgraded my machine to redhat 7.2 (from redhat 6.2) and I am
> constantly (eg < 1 hour of uptime) getting kernel crashes which I believe
> are relating to ext3.  I know I should submit this to redhat's bugzilla, but
> before I do I was hoping someone on the list might want to comment as I am
> sure it is probably something I am doing wrong.
> 
> The machine has previously been rock solid, and the only hardware change I
> have made recently is to add an extra 64M of RAM (Total 128MB).  I have run
> memtest86 on it for 10 hours with no errors reported.
> 
> The last error I get is
> Assertion failure in __journal_file_buffer() at transaction.c:1953:
> "jh->b_jlist < 9".  I can still switch between consoles, but cannot do much
> else other than press the reset button :(
> 

ext3 downloads are currently running at 1,200 per day plus
an unknown number of Red Hat users, and you're the first to report
this one.   So it's going to be something odd.  It _could_ be bad
hardware, but if it's always failing in the same way, that sounds
unlikely.

Could you please force a `fsck' against the fs, let us know the
outcome?

Also, a ksymoops trace of the oops output would be most useful.

It looks like memory corruption of some form - a structure
member has an impossible value.  Are you using any less-than-mainstream
device drivers in that box?

-
