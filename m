Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261335AbSJULxB>; Mon, 21 Oct 2002 07:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261338AbSJULxB>; Mon, 21 Oct 2002 07:53:01 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:56499 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261335AbSJULxA>; Mon, 21 Oct 2002 07:53:00 -0400
Subject: Re: [PATCH] work around duff ABIs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Wilcox <willy@debian.org>
Cc: Erik Andersen <andersen@codepoet.org>, Alexander Viro <viro@math.psu.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021020135109.D5285@parcelfarce.linux.theplanet.co.uk>
References: <20021020053147.C5285@parcelfarce.linux.theplanet.co.uk>
	<20021020045149.GA27887@codepoet.org> 
	<20021020135109.D5285@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 13:14:43 +0100
Message-Id: <1035202483.27259.62.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-10-20 at 13:51, Matthew Wilcox wrote: 
> asmlinkage ssize_t sys_pread64(unsigned int fd, char *buf, size_t count,
> 				loff_t pos)
> 

Which ABI. If its the hppa ABI then its however you specified it and
however your call setup/return code handles it. If that needs glue and
your own syscall vectors calling sys_pread64 indirectly BFD.

