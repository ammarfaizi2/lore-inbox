Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314556AbSEMWvl>; Mon, 13 May 2002 18:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314557AbSEMWvk>; Mon, 13 May 2002 18:51:40 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:53915 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S314556AbSEMWvk>; Mon, 13 May 2002 18:51:40 -0400
Date: Mon, 13 May 2002 17:50:37 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Ulrich Weigand <weigand@immd1.informatik.uni-erlangen.de>
cc: zaitcev@redhat.com, <linux-kernel@vger.kernel.org>
Subject: Re: Strange s390 code in 2.4.19-pre8
In-Reply-To: <200205132242.AAA11464@faui1a.informatik.uni-erlangen.de>
Message-ID: <Pine.LNX.4.44.0205131747290.19498-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2002, Ulrich Weigand wrote:

> As it is not possible to configure the ISDN fsm.o into a s390
> build (and there is in fact no ISDN hardware for S/390 ;-/),
> how can there be any conflict?

The version strings for export symbols are generated at "make dep" time, 
which iterates over all subdirectories (well, only arch/$ARCH, but all 
the rest) without caring about config options. So generating symbols will 
conflict if $ARCH == s390.

--Kai


