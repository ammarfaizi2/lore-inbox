Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264612AbSKDBPI>; Sun, 3 Nov 2002 20:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264611AbSKDBPI>; Sun, 3 Nov 2002 20:15:08 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:59404
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S264612AbSKDBPH>; Sun, 3 Nov 2002 20:15:07 -0500
Subject: Re: Some functions are not inlined by gcc 3.2, resulting code is
	ugly
From: Robert Love <rml@tech9.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jakub Jelinek <jakub@redhat.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@suse.de>
In-Reply-To: <1036340502.29642.36.camel@irongate.swansea.linux.org.uk>
References: <200211031125.gA3BP4p27812@Port.imtp.ilyichevsk.odessa.ua>
	<200211031322.gA3DMTp28125@Port.imtp.ilyichevsk.odessa.ua> 
	<20021103103710.D10988@devserv.devel.redhat.com> 
	<1036340502.29642.36.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Nov 2002 20:21:32 -0500
Message-Id: <1036372893.752.11.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-03 at 11:21, Alan Cox wrote:

> I would venture the reverse interpretation for modern processors,
> the kernel inlines far far too much

I agree 100% we mark too much as inline - but at the same time, some
larger functions are inline simply because they were originally part of
another function and pulled out for cleanliness.  They are only used
once...  in other words, in some cases I hope the kernel developers know
what they are doing when they mark stuff inline.

So I can see why bumping this limit very high is a good thing.  At the
same time, there is a lot of stuff incorrectly inlined and we should go
through and un-inline all of that, too.

	Robert Love

