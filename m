Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267278AbTBXRHc>; Mon, 24 Feb 2003 12:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267281AbTBXRHb>; Mon, 24 Feb 2003 12:07:31 -0500
Received: from mons.uio.no ([129.240.130.14]:38889 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S267278AbTBXRH2>;
	Mon, 24 Feb 2003 12:07:28 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15962.21418.869267.676983@charged.uio.no>
Date: Mon, 24 Feb 2003 18:17:30 +0100
To: Oleg Drokin <green@namesys.com>
Cc: Andrew Morton <akpm@digeo.com>, vs@namesys.com, nikita@namesys.com,
       jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.4 iget5_locked port attempt to 2.4 (supposedly fixed NFS version this time)
In-Reply-To: <20030224200323.A18408@namesys.com>
References: <20030220175309.A23616@namesys.com>
	<20030220154924.7171cbd7.akpm@digeo.com>
	<20030221220341.A9325@namesys.com>
	<20030221200440.GA23699@delft.aura.cs.cmu.edu>
	<20030224132145.A7399@namesys.com>
	<15962.19783.182617.822504@charged.uio.no>
	<20030224200323.A18408@namesys.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Oleg Drokin <green@namesys.com> writes:

    >> like that keeps turning the clock backward on the server, then
    >> the NFS client has no chance of recognizing which attribute
    >> updates are the more recent ones.

     > Ok, I stopped ntpd. Will see what will happen. ;) Aha, it died
     > already: doread: read: Input/output error

Silly question: Are you perhaps testing using the 'soft' mount option?

     > How about that "RPC request reserved 1144 but used 4024" alike
     > stuff"?

Sounds like Neil made another accounting error in the server code
8-). Can you try to check on which type of request it occurs (readdir,
read, readlink?).

Cheers,
  Trond
