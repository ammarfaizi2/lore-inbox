Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264968AbSKERrv>; Tue, 5 Nov 2002 12:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265092AbSKERrv>; Tue, 5 Nov 2002 12:47:51 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:35733 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264968AbSKERru>; Tue, 5 Nov 2002 12:47:50 -0500
Subject: Re: [PATCH] Re: time() glitch on 2.4.18: solved
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Willy Tarreau <willy@w.ods.org>
Cc: Jim Paris <jim@jtan.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021105171035.GB879@alpha.home.local>
References: <20021102013704.A24684@neurosis.mit.edu>
	<20021103143216.A27147@neurosis.mit.edu>
	<1036355418.30679.28.camel@irongate.swansea.linux.org.uk>
	<20021105113020.A5210@neurosis.mit.edu> 
	<20021105171035.GB879@alpha.home.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Nov 2002 18:16:31 +0000
Message-Id: <1036520191.5012.109.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-05 at 17:10, Willy Tarreau wrote:
> On Tue, Nov 05, 2002 at 11:30:20AM -0500, Jim Paris wrote:
> > +		if (count > LATCH) {
> 
> may be (count >= LATCH) would be even better ?

Some PIT clones seem to hold the LATCH value momentarily judging by
other things that were triggered wrongly by >=

