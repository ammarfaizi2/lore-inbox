Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276340AbRI1WMw>; Fri, 28 Sep 2001 18:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276342AbRI1WMm>; Fri, 28 Sep 2001 18:12:42 -0400
Received: from balabit.bakats.tvnet.hu ([195.38.106.66]:5643 "EHLO
	kuka.balabit") by vger.kernel.org with ESMTP id <S276340AbRI1WMc>;
	Fri, 28 Sep 2001 18:12:32 -0400
Date: Sat, 29 Sep 2001 00:12:45 +0200
From: Balazs Scheidler <bazsi@balabit.hu>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reproducible bug in 2.2.19 & 2.4.x
Message-ID: <20010929001245.A25486@balabit.hu>
In-Reply-To: <20010928203019.A24999@balabit.hu> <Pine.LNX.4.10.10109281515050.6506-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10109281515050.6506-100000@coffee.psychology.mcmaster.ca>; from hahn@physics.mcmaster.ca on Fri, Sep 28, 2001 at 03:15:32PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2001 at 03:15:32PM -0400, Mark Hahn wrote:
> 
> seems like an interaction between your signal code and pthread,
> no obvious reason to blame the kernel:
[snip]

If you check out the code again, you can see that I _don't_ have signal code
for SIGPIPE, it's SIG_IGN-ed. I only have signal handler for SIGSEGV, which
is executed when the bogus jump occurrs to 0x1.

I agree that this can be either a kernel, pthread or libc problem.

BTW: the SIGSEGV occurs on UP machine with SMP kernel as well.

-- 
Bazsi
PGP info: KeyID 9AF8D0A9 Fingerprint CD27 CFB0 802C 0944 9CFD 804E C82C 8EB1
