Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262420AbREUJkC>; Mon, 21 May 2001 05:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262421AbREUJjw>; Mon, 21 May 2001 05:39:52 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:57869 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262420AbREUJjl>;
	Mon, 21 May 2001 05:39:41 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: kees <kees@schoen.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Hang with SMP 2.4.4 snd log 
In-Reply-To: Your message of "Mon, 21 May 2001 10:26:20 +0200."
             <Pine.LNX.4.21.0105211022430.4818-200000@schoen3.schoen.nl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 21 May 2001 19:39:23 +1000
Message-ID: <9363.990437963@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 May 2001 10:26:20 +0200 (CEST), 
kees <kees@schoen.nl> wrote:
>I got a next hang with my SMP system, kdb log attached. Something strange
>with the backtrace for CPU 0. Here is the first cut from the kdb log..

I do not trust either of those backtraces.  There is no way to get from
do_nmi to do_exit.  The presence of "unknown" entries indicates that
the cpu 0 back trace is bad.  Also all the ebp pointers are suspect,
they are way out of range for the task addresses.  You could be looking
at a stack overrun or just random corruption of kernel data.

If you can reproduce the problem, set KDBDEBUG=0xff and bt.  That will
debug kdb and produce a lot of output.  Send it to me, although I
suspect it will just prove that you have stack corruption.

