Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267535AbRGMTyr>; Fri, 13 Jul 2001 15:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267536AbRGMTyh>; Fri, 13 Jul 2001 15:54:37 -0400
Received: from weta.f00f.org ([203.167.249.89]:11395 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S267535AbRGMTyU>;
	Fri, 13 Jul 2001 15:54:20 -0400
Date: Sat, 14 Jul 2001 07:54:20 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Mike Kravetz <mkravetz@sequent.com>
Cc: Larry McVoy <lm@bitmover.com>, Davide Libenzi <davidel@xmailserver.org>,
        lse-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: CPU affinity & IPI latency
Message-ID: <20010714075420.A5596@weta.f00f.org>
In-Reply-To: <20010712164017.C1150@w-mikek2.des.beaverton.ibm.com> <XFMail.20010712172255.davidel@xmailserver.org> <20010712173641.C11719@work.bitmover.com> <20010713100521.D1137@w-mikek2.des.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010713100521.D1137@w-mikek2.des.beaverton.ibm.com>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2001 at 10:05:21AM -0700, Mike Kravetz wrote:

    It is clear that the behavior of lat_ctx bypasses almost all of
    the scheduler's attempts at CPU affinity.  The real question is,
    "How often in running 'real workloads' are the schduler's attempts
    at CPU affinity bypassed?".

When encoding mp3s on a dual processor system, naturally I try to
encode two at once.

Most of the time this works as expected, one processed more or less
sticks to each CPU.  However, I have noticed that if for some reason,
a third process has to be scheduled (which is inevitable if you
actually want to do anything), then these two processes seem to bounce
back and forward for a few seconds, _even_ after this CPU spike has
gone.

Now, I'm not sure if I'm imagining this or not, as I said, I have two
CPUs and two CPU-bound tasks, to instrument this as all, I really have
to affect what I am looking at (rather like the uncertainty principal)
so I assumed that perhaps my programs to read and process
/proc/<n>/cpu was simply eating several cycles and each process was
yielding more or less at random causing what I saw seeing.



   --cw
