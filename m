Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264945AbTATAIV>; Sun, 19 Jan 2003 19:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267726AbTATAIV>; Sun, 19 Jan 2003 19:08:21 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:27008 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S264945AbTATAIU>;
	Sun, 19 Jan 2003 19:08:20 -0500
Subject: Re: problems with nfs-server in 2.5 bk as of 030115
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15915.13242.291976.585239@charged.uio.no>
References: <1043012373.7986.94.camel@tux.rsn.bth.se>
	 <15915.8496.899499.957528@charged.uio.no>
	 <1043016608.727.0.camel@tux.rsn.bth.se>
	 <15915.13242.291976.585239@charged.uio.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043021842.679.1.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 20 Jan 2003 01:17:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-20 at 00:24, Trond Myklebust wrote:
> >>>>> " " == Martin Josefsson <gandalf@wlug.westbo.se> writes:
> 
>      > On Sun, 2003-01-19 at 23:05, Trond Myklebust wrote:
>     >> Could you apply the following patch, so that I can see what the
>     >> actual returned error is?
> 
>      > RPC: Couldn't create pipefs entry /portmap/clnteb11b574, error
>      > -17 RPC: Couldn't create pipefs entry /portmap/clnteb11b574,
>      > error -17 RPC: Couldn't create pipefs entry
>      > /portmap/clnteb11b574, error -17
> 
> OK. That's what I thought it might be...
> 
> Looks like rmdir() is failing, so that when 'clnt' gets reused, then
> a directory with the old pathname still exists so mkdir() fails...
> 
> Could you try applying the following extra patch, just in order to
> confirm that this is indeed the case (and to trace what the eventual
> rmdir() error might be)?

With two added ; the patch compiled and produced this output:

Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
rpc_destroy_client: rpc_rmdir(/portmap/clnteb10c63c) failed with error -39
RPC: Couldn't create pipefs entry /portmap/clnteb10c63c, error -17
RPC: Couldn't create pipefs entry /portmap/clnteb10c63c, error -17
RPC: Couldn't create pipefs entry /portmap/clnteb10c63c, error -17

-- 
/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.
