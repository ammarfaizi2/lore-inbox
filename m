Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266764AbUG1CR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266764AbUG1CR0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 22:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266766AbUG1CRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 22:17:25 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:42921 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S266764AbUG1CRY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 22:17:24 -0400
Subject: Re: [PATCH] Deadlock during heavy write activity to userspace NFS
	server on local NFS mount
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Avi Kivity <avi@exanet.com>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
In-Reply-To: <41070183.5000701@yahoo.com.au>
References: <41050300.90800@exanet.com>
	 <20040726210229.GC21889@openzaurus.ucw.cz> <4106B992.8000703@exanet.com>
	 <20040727203438.GB2149@elf.ucw.cz> <4106C2E8.905@exanet.com>
	 <41070183.5000701@yahoo.com.au>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1090981035.14637.30.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 27 Jul 2004 22:17:15 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På ty , 27/07/2004 klokka 21:29, skreiv Nick Piggin:

> There is some need arising for a call to set the PF_MEMALLOC flag for
> userspace tasks, so you could probably get a patch accepted. Don't
> call it KSWAPD_HELPER though, maybe MEMFREE or RECLAIM or RECLAIM_HELPER.
> 
> But why is your NFS server needed to reclaim memory? Do you have the
> filesystem mounted locally?

...and why can't this problem be fixed by judicious use of mlock()?

Cheers,
  Trond
