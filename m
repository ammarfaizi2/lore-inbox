Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261330AbSJDBIB>; Thu, 3 Oct 2002 21:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261386AbSJDBIB>; Thu, 3 Oct 2002 21:08:01 -0400
Received: from pat.uio.no ([129.240.130.16]:61688 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S261330AbSJDBIA>;
	Thu, 3 Oct 2002 21:08:00 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15772.60202.510717.850059@charged.uio.no>
Date: Fri, 4 Oct 2002 03:13:14 +0200
To: Christian Reis <kiko@async.com.br>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, NFS@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.19+trond and diskless locking problems
In-Reply-To: <20021003202602.M3869@blackjesus.async.com.br>
References: <20021003184418.K3869@blackjesus.async.com.br>
	<shsy99f16np.fsf@charged.uio.no>
	<20021003202602.M3869@blackjesus.async.com.br>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Christian Reis <kiko@async.com.br> writes:

    >> >     kernel:Aug 10 17:39:22 anthem kernel: lockd: cannot
    >> >     monitor 192.168.99.7
    >>
    >> Means that the kernel was unable to contact rpc.statd, or that
    >> was unable to contact the server's rpc.statd for some reason.

     > Hmmm, I wonder if I understand properly. Is the following flow
     > correct for the RPC request?

     >     Client Kernel -> Client rpc.statd -> Server rpc.statd ->
     >     Server Kernel

That's more or less right, except that the communication is bidirectional.

    >> lies with rpc.statd.  Can you see any reason in your setup why
    >> it should be failing?

     > Not really. The clients run rpc.statd 1.0 and the server,
     > 1.0.1. Should I start gdbing it to see what is going wrong?

Start by using tcpdump to find out who, in the above chain, is taking
such a long time to respond.

Cheers,
  Trond
