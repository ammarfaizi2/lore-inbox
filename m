Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265929AbUA0U4I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 15:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265931AbUA0UzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 15:55:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:47496 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265929AbUA0Uyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 15:54:51 -0500
Date: Tue, 27 Jan 2004 12:54:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: eric@cisu.net, stoffel@lucent.com, ak@muc.de, Valdis.Kletnieks@vt.edu,
       bunk@fs.tum.de, cova@ferrara.linux.it, linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
Message-Id: <20040127125447.31631e14.akpm@osdl.org>
In-Reply-To: <20040127162043.GA98702@colin2.muc.de>
References: <200401232253.08552.eric@cisu.net>
	<200401261326.09903.eric@cisu.net>
	<20040126115614.351393f2.akpm@osdl.org>
	<200401262343.35633.eric@cisu.net>
	<20040126215056.4e891086.akpm@osdl.org>
	<20040127162043.GA98702@colin2.muc.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
> > Can you plesae confirm that restoring only -funit-at-a-time again produces
> > a crashy kernel?  And that you are using a flavour of gcc-3.3?  If so, I
> 
> It works just fine on the SuSE 9.0 3.3-hammer gcc. 
> 
> So far the reports point to some Mandrake gcc 3.3 having problems
> (they used an older version of Hammer branch). It's hard to be sure
> because everybody having any problem with the kernel seems to like
> to report it to this thread :-) But before just disabling
> it I would like to track down the problem and see if it's really a 
> compiler issue or something that can be fixed in the kernel.
> 
> If you really want to disable it I would prefer to only check for that
> compiler version and keep it for working 3.3-hammers.

I've moved the enabling of -funit-at-a-time out of Makefile and down into
arch/i386/Makefile, and I changed to require gcc-3.4 or higher.

So if you want to use -funit-at-a-time on gcc-3.3/hammer you can do so.

