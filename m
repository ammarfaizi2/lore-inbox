Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267005AbTAZVkP>; Sun, 26 Jan 2003 16:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267007AbTAZVkO>; Sun, 26 Jan 2003 16:40:14 -0500
Received: from pat.uio.no ([129.240.130.16]:52360 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S267005AbTAZVkN>;
	Sun, 26 Jan 2003 16:40:13 -0500
To: Christian Reis <kiko@async.com.br>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
       NFS@lists.sourceforge.net
Subject: Re: [NFS] Re: NFS client locking hangs for period
References: <20030124184951.A23608@blackjesus.async.com.br>
	<15922.2657.267195.355147@notabene.cse.unsw.edu.au>
	<20030126140200.A25438@blackjesus.async.com.br>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 26 Jan 2003 22:49:14 +0100
In-Reply-To: <20030126140200.A25438@blackjesus.async.com.br>
Message-ID: <shs8yx7lgyt.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Christian Reis <kiko@async.com.br> writes:

     > I wonder why you can't do locking on NFS root (if it's a
     > current limitation of if it doesn't make sense).

locking supposes that you are already running a statd daemon, which
you clearly cannot be doing on an nfsroot system. If you need locking
on a root partition, then you'll need to set up an initrd from which
to start all the necessary daemons...

BTW: Did I understand you and Neil correctly when you appeared to say
that you were sharing the *same* root partition between several
clients?

If so, then that could easily explain your problem: a directory like
/var/lib/nfs simply cannot be shared among several different
machines. Read the 'statd' manpage, and I'm sure you will understand
why.

Cheers,
  Trond
