Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276022AbRI1Sai>; Fri, 28 Sep 2001 14:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276225AbRI1SaU>; Fri, 28 Sep 2001 14:30:20 -0400
Received: from balabit.bakats.tvnet.hu ([195.38.106.66]:16391 "EHLO
	kuka.balabit") by vger.kernel.org with ESMTP id <S276021AbRI1SaK>;
	Fri, 28 Sep 2001 14:30:10 -0400
Date: Fri, 28 Sep 2001 20:30:19 +0200
From: Balazs Scheidler <bazsi@balabit.hu>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reproducible bug in 2.2.19 & 2.4.x
Message-ID: <20010928203019.A24999@balabit.hu>
In-Reply-To: <20010928130138.A19532@balabit.hu> <Pine.LNX.4.10.10109281121590.6506-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10109281121590.6506-100000@coffee.psychology.mcmaster.ca>; from hahn@physics.mcmaster.ca on Fri, Sep 28, 2001 at 11:22:45AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2001 at 11:22:45AM -0400, Mark Hahn wrote:
> >   - each thread logs messages using syslog (libc changes SIGPIPE settings
> 
> it does syslog from within the signal handler?  I doubt that's legal.

you are right, but the problem is that the handler gets called at all.

the sigsegv doesn't happen within the signal handler, if you look at the
backtrace, it happens during the write() syscall.

-- 
Bazsi
PGP info: KeyID 9AF8D0A9 Fingerprint CD27 CFB0 802C 0944 9CFD 804E C82C 8EB1
