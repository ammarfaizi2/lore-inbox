Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130339AbRAJRdg>; Wed, 10 Jan 2001 12:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135972AbRAJRd0>; Wed, 10 Jan 2001 12:33:26 -0500
Received: from Cantor.suse.de ([194.112.123.193]:64519 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130339AbRAJRdQ>;
	Wed, 10 Jan 2001 12:33:16 -0500
Date: Wed, 10 Jan 2001 18:32:56 +0100
From: Andi Kleen <ak@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Daniel Phillips <phillips@innominate.de>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
Message-ID: <20010110183256.A28025@gruyere.muc.suse.de>
In-Reply-To: <dnbstgewoj.fsf@magla.iskon.hr> <Pine.LNX.4.10.10101091041150.2070-100000@penguin.transmeta.com> <3A5B61F7.FB0E79C1@innominate.de> <shsvgror0ch.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <shsvgror0ch.fsf@charged.uio.no>; from trond.myklebust@fys.uio.no on Tue, Jan 09, 2001 at 08:29:02PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 08:29:02PM +0100, Trond Myklebust wrote:
> Al has mentioned that he wants us to move towards a *BSD-like system
> of credentials (i.e. struct ucred) that could be used here, but that's
> in the far future. In the meantime, we cache RPC credentials in the
> struct file...

struct ucred is also needed to get LinuxThreads POSIX compliant (sharing
credentials between threads, but still keeping system calls atomic in
relation to credential changes) 


-Andi (who doesn't want to know how many security holes are in linux ported
programs using threads and set*id() because of that) 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
