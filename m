Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266941AbTBCRuo>; Mon, 3 Feb 2003 12:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266938AbTBCRuo>; Mon, 3 Feb 2003 12:50:44 -0500
Received: from esperi.demon.co.uk ([194.222.138.8]:8208 "EHLO
	esperi.demon.co.uk") by vger.kernel.org with ESMTP
	id <S266286AbTBCRun>; Mon, 3 Feb 2003 12:50:43 -0500
To: trond.myklebust@fys.uio.no
Cc: ultralinux@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: strange sparc64 -> i586 intermittent but reproducible NFS write errors to one and only one fs
References: <87bs2q3paq.fsf@amaterasu.srvr.nix>
	<200301100658.h0A6vxs14580@Port.imtp.ilyichevsk.odessa.ua>
	<87iswkx53u.fsf@amaterasu.srvr.nix>
	<15915.4574.380686.123067@charged.uio.no>
X-Emacs: well, why *shouldn't* you pay property taxes on your editor?
From: Nix <nix@esperi.demon.co.uk>
Date: 03 Feb 2003 17:35:03 +0000
In-Reply-To: <15915.4574.380686.123067@charged.uio.no>
Message-ID: <87adhd6zeg.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Military Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jan 2003, Trond Myklebust said:
> It sounds rather strange that this particular patch should introduce
> an EIO, but here it is (fresh from BitKeeper)

... and indeed it doesn't.

The problem still exists in -pre9, but is very much rarer and harder to
replicate; I've sene it only half a dozen times in two weeks, in each
case during an ftp retrieval; I'm assuming there's something about the
write patterns used by ncftp (lots of few-KB appends, far apart in time)
that triggers it.

So it really is merely a timing change that has brought a pre-existing
problem into the light.

I'm going to try to come up with something that consistently reproduces
this as well, so I can track down the origins of this bug more
correctly.

-- 
2003-02-01: the day the STS died.
