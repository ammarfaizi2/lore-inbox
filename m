Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267424AbTA1QjK>; Tue, 28 Jan 2003 11:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267431AbTA1QjK>; Tue, 28 Jan 2003 11:39:10 -0500
Received: from 200-206-134-238.async.com.br ([200.206.134.238]:35014 "EHLO
	anthem.async.com.br") by vger.kernel.org with ESMTP
	id <S267424AbTA1QjJ>; Tue, 28 Jan 2003 11:39:09 -0500
Date: Tue, 28 Jan 2003 14:47:59 -0200
From: Christian Reis <kiko@async.com.br>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
       NFS@lists.sourceforge.net
Subject: Re: [NFS] Re: NFS client locking hangs for period
Message-ID: <20030128144759.D11078@blackjesus.async.com.br>
References: <20030124184951.A23608@blackjesus.async.com.br> <shs8yx7lgyt.fsf@charged.uio.no> <20030126204711.A25997@blackjesus.async.com.br> <200301280815.h0S8FLs10146@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200301280815.h0S8FLs10146@Port.imtp.ilyichevsk.odessa.ua>; from vda@port.imtp.ilyichevsk.odessa.ua on Tue, Jan 28, 2003 at 10:14:09AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2003 at 10:14:09AM +0200, Denis Vlasenko wrote:
> > None of the users have root access so writing to the partition only
> > is done as the result of servers running. I used a lot of reboots and
> > ls -lt to find out what needs to be separate, and there are few
> > issues that need fixing (/etc/ioctl.save being the latest).
> 
> Entire /etc.  How can you have different per-client configs for
> e.g. /etc/resolv.conf?  I know you don't usually need that.
> Sometimes we need to do unusual things ;)

Well, the per-client configurations are an exception at our office, and
the only things we customize are XFree86 (we use the
Xfree86Config.hostname capability), gpm and the kernel, which is
dealt out by DHCPD. We also have a special startup script that is run
for the named box if it exists (/etc/init.d/host-specific/`hostname`).

I'm sure this won't work for everybody, but it does work for us, a
smallish development team.

> Same here. Devfs is cool ;)
> For one, it forces people to think before they got strange ideas of
> putting something foreign in /dev. Like abm syslogd.

Only after using devfs in this context have I come to appreciate how
nice it is. And I had it in place after 10 minutes of reading and two of
recompiled kernels. Amazing.

Take care,
--
Christian Reis, Senior Engineer, Async Open Source, Brazil.
http://async.com.br/~kiko/ | [+55 16] 261 2331 | NMFL
