Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131644AbREFCcB>; Sat, 5 May 2001 22:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131626AbREFCbw>; Sat, 5 May 2001 22:31:52 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:5897 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S131497AbREFCbl>;
	Sat, 5 May 2001 22:31:41 -0400
Date: Sat, 5 May 2001 23:31:21 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Chris Wedgwood <cw@f00f.org>
Cc: Peter Rival <frival@zk3.dec.com>, Anton Blanchard <anton@samba.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CPU hot swap for 2.4.3 + s390 support
In-Reply-To: <20010506142548.D31269@metastasis.f00f.org>
Message-ID: <Pine.LNX.4.21.0105052329230.582-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 May 2001, Chris Wedgwood wrote:
> On Sat, May 05, 2001 at 11:19:09PM -0300, Rik van Riel wrote:
> 
>     This only leaves two issues, the first is device drivers and the
>     second is the question whether we'd want the overhead needed to
>     implement the (fairly easy) memory relocation.
> 
> How do you relocate
> 
>   -- pages which are mlocked without violating RT contraints?

Fuck RT constraints. Linux doesn't have infinitely small
scheduling latencies, it's easy to copy a page without
increasing the scheduling latencies much.

>   -- pages which contain kernel pointers and might be accessed from
>      interrupt context?

Block interrupts while copying a kernel page?


Remember that this is an emergency situation, so it's ok
to use "big hammer" solutions.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

