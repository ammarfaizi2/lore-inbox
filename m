Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264787AbUEPSvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264787AbUEPSvI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 14:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264786AbUEPSvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 14:51:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:42432 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264787AbUEPSu7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 14:50:59 -0400
Date: Sun, 16 May 2004 11:50:51 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Andreas Amann <amann@physik.tu-berlin.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6 breaks kmail (nfs related?)
In-Reply-To: <1084733234.3764.30.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.58.0405161149430.25502@ppc970.osdl.org>
References: <200405131411.52336.amann@physik.tu-berlin.de> 
 <Pine.LNX.4.58.0405152142400.25502@ppc970.osdl.org> 
 <1084730382.3764.7.camel@lade.trondhjem.org>  <1084731015.3764.10.camel@lade.trondhjem.org>
  <Pine.LNX.4.58.0405161115000.25502@ppc970.osdl.org>
 <1084733234.3764.30.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 16 May 2004, Trond Myklebust wrote:
> 
> If kmail really is reporting an ENOSPC, though, then it's hard to see
> how a signal could produce that particular error.

Agreed. But the kmail message is apparently "(No space left on device?)", 
which may be just kmail itself reacting to a truncated write rather than 
any actual ENOSPC error.  A "strace" would help clarify exactly what goes 
wrong..

		Linus
