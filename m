Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264785AbUEPSrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264785AbUEPSrR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 14:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264787AbUEPSrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 14:47:17 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:11402 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S264785AbUEPSrQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 14:47:16 -0400
Subject: Re: 2.6.6 breaks kmail (nfs related?)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andreas Amann <amann@physik.tu-berlin.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405161115000.25502@ppc970.osdl.org>
References: <200405131411.52336.amann@physik.tu-berlin.de>
	 <Pine.LNX.4.58.0405152142400.25502@ppc970.osdl.org>
	 <1084730382.3764.7.camel@lade.trondhjem.org>
	 <1084731015.3764.10.camel@lade.trondhjem.org>
	 <Pine.LNX.4.58.0405161115000.25502@ppc970.osdl.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1084733234.3764.30.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 16 May 2004 14:47:14 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På su , 16/05/2004 klokka 14:19, skreiv Linus Torvalds:
> They were in the original email on the kernel mailing list:

Sorry. I was in Malaysia last week so that email probably drowned in the
1600 other mails I found in my backlog when I returned on Friday. I've
found it now in the archives...

> 	hservnlds:/home /net/hservnlds/home nfs rw,nosuid,nodev,v3,rsize=8192,wsize=8192,hard,intr,udp,lock,addr=sservnlds 0 
> 
> The only thing there is that "intr". Maybe something has broken so that 
> non-lethal signals also trigger errors? That could explain it (partial 
> reads or writes when a timer goes off, or something). 

I haven't touched rpc_clnt_sigmask() in many years, so that would have
to be some change to the generic signal handling code.

If kmail really is reporting an ENOSPC, though, then it's hard to see
how a signal could produce that particular error.

Cheers,
  Trond
