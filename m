Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267123AbTAHLmO>; Wed, 8 Jan 2003 06:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267133AbTAHLmN>; Wed, 8 Jan 2003 06:42:13 -0500
Received: from 200-206-134-238.async.com.br ([200.206.134.238]:29312 "EHLO
	anthem.async.com.br") by vger.kernel.org with ESMTP
	id <S267123AbTAHLmM>; Wed, 8 Jan 2003 06:42:12 -0500
Date: Wed, 8 Jan 2003 09:50:50 -0200
From: Christian Reis <kiko@async.com.br>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: NFS@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: /var/lib/nfs/sm/ files
Message-ID: <20030108095050.C22321@blackjesus.async.com.br>
References: <20030107132743.E2628@blackjesus.async.com.br> <shsn0mcj3x8.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <shsn0mcj3x8.fsf@charged.uio.no>; from trond.myklebust@fys.uio.no on Tue, Jan 07, 2003 at 05:54:59PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2003 at 05:54:59PM +0100, Trond Myklebust wrote:
> >>>>> " " == Christian Reis <kiko@async.com.br> writes:
> 
>      > Hi there,
> 
>      > Can `anybody' (Neil, Trond?) explain what the entries in
>      > /var/lib/nfs/sm/ are for? If they refer to file locks, can we
> 
> 'man rpc.statd'. Those files store the IP-addresses of the machines
> being monitored by statd. In case of a crash or a reboot, those files
> tell statd which machines that need to be notified.

Thanks. So my questions are related to what `monitored by statd' means:
    
    - Why don't all the diskless workstations get an entry in that
      directory while they are running? Right now I have 5 running, and
      only one has an entry there.

    - Why do most entries' mtime get updated periodically, but a few of
      the entries go stale with time?
      
    - Why do some of the stale entries get left over even after the
      workstations have halted (these ones present the nfs hang issue)?

Take care,
--
Christian Reis, Senior Engineer, Async Open Source, Brazil.
http://async.com.br/~kiko/ | [+55 16] 261 2331 | NMFL
