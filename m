Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293217AbSCRWwk>; Mon, 18 Mar 2002 17:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293206AbSCRWwd>; Mon, 18 Mar 2002 17:52:33 -0500
Received: from mons.uio.no ([129.240.130.14]:32757 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S293217AbSCRWwK>;
	Mon, 18 Mar 2002 17:52:10 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15510.28326.558485.955067@charged.uio.no>
Date: Mon, 18 Mar 2002 23:48:06 +0100
To: Pavel Machek <pavel@suse.cz>
Cc: Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        Jonathan Barker <jbarker@ebi.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: VFS mediator?
In-Reply-To: <20020318223827.GD1740@atrey.karlin.mff.cuni.cz>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Pavel Machek <pavel@suse.cz> writes:

     > Okay, take userland nfs-server. (This thread was about userland
     > filesystems).

Yech... Nobody should be seriously considering using unfsd: it does
not even manage to follow the NFS protocol. That inability was one of
the many reasons why Olaf Kirch abandoned further develpement of unfsd
and started work on knfsd.

     > Then, make memory full of dirty pages. Imagine that nfs-server
     > is swapped-out by some bad luck. What you have is extremely
     > nasty deadlock, AFAICS. [To free memory you have to write out
     > dirty data, but you can't do that because you don't have enough
     > memory for nfs-server].

So that is another argument for using knfsd rather than unfsd. I will
agree with you that NFS is not perfect, but please judge it on its
actual merits and not on some trumped up charge...

Cheers,
  Trond
