Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316096AbSEJTxz>; Fri, 10 May 2002 15:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316097AbSEJTxy>; Fri, 10 May 2002 15:53:54 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:20438 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S316096AbSEJTxw>; Fri, 10 May 2002 15:53:52 -0400
Date: Fri, 10 May 2002 21:54:06 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "David S. Miller" <davem@redhat.com>
cc: dizzy@roedu.net, linux-kernel@vger.kernel.org
Subject: Re: mmap, SIGBUS, and handling it
In-Reply-To: <20020510.095600.90795538.davem@redhat.com>
Message-ID: <Pine.GSO.3.96.1020510213633.16282A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 May 2002, David S. Miller wrote:

> He's talking about how SIG_IGN should behave.

 So do I.

> If you want non-default behavior, specify a signal handler instead
> of SIG_IGN.

 Well, SIG_IGN is non-default (user-specified) behavior -- SIG_DFL is. 

>     Why should we enforce policy on a user?  If one wants to ignore such
>    signals for whatever reason, let him do that. 
>    
> We don't specify any policy other than the behavior of SIG_IGN which
> is to kill off the process for SIGBUS.

 Making a special exception to well-defined semantics because it seems
less useful for a certain case is policy.  SIG_IGN means to ignore a
signal (except from SIGKILL, SIGSTOP, SIGCONT signals that cannot be
ignored, but that's a result of how they work and it is explicitly
specified in standards) -- everything else is unexpected semantics. 

> If you specify a handler you can have SIGBUS do whatever you want it
> to.  There are no enforced limitations, only a specified behavior
> for SIG_IGN when used for SIGBUS.
> 
> The original poster has solved his problem, yet you continue to argue
> one and on and on.

 s/argue/discuss/

 Anyway, since the code seems to work like I describe/expect, there is
really no problem for me.  Haven't you meant SIG_DFL, actually? 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

