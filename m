Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWEaWwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWEaWwc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 18:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbWEaWwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 18:52:32 -0400
Received: from mse2fe2.mse2.exchange.ms ([66.232.26.194]:26735 "EHLO
	mse2fe2.mse2.exchange.ms") by vger.kernel.org with ESMTP
	id S964782AbWEaWwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 18:52:31 -0400
Subject: Re: linux-2.6 x86_64 kgdb issue
From: Piet Delaney <piet@bluelane.com>
Reply-To: piet@bluelane.com
To: Andi Kleen <ak@suse.de>
Cc: Piet Delaney <piet@bluelane.com>, Tom Rini <trini@kernel.crashing.org>,
       "Amit S. Kale" <amitkale@linsyssoft.com>,
       "Vladimir A. Barinov" <vbarinov@ru.mvista.com>,
       Andrew Morton <akpm@osdl.org>, kgdb-bugreport@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <200605312301.56452.ak@suse.de>
References: <446E0B4B.9070003@ru.mvista.com> <200605310913.54758.ak@suse.de>
	 <20060531150343.GZ31210@smtp.west.cox.net>  <200605312301.56452.ak@suse.de>
Content-Type: multipart/mixed; boundary="=-/UlZGbhnV/5HwUkiQYWX"
Organization: BlueLane Tech,
Date: Wed, 31 May 2006 15:52:25 -0700
Message-Id: <1149115945.26542.208.camel@piet2.bluelane.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4-3mdk 
X-OriginalArrivalTime: 31 May 2006 22:52:30.0657 (UTC) FILETIME=[E5B0CB10:01C68504]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/UlZGbhnV/5HwUkiQYWX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2006-05-31 at 23:01 +0200, Andi Kleen wrote:
> On Wednesday 31 May 2006 17:03, Tom Rini wrote:
> > On Wed, May 31, 2006 at 09:13:53AM +0200, Andi Kleen wrote:
> >
> > [snip]
> >
> > > Yes because you if modular works you don't need to build it in.
> > >
> > > Modular was working at some point on x86-64 for kdb and the original 2.6
> > > version of kgdb was nearly there too.
> >
> > FWIW, the only change the current version of kgdb makes that would
> > prevent it from being totally modular is the debugger_active check in
> > 
> 
> Can you post the patch and a description? 

It's maintained at SourceForge:

	http://sourceforge.net/projects/kgdb

Patches can be downloaded from:
	
	http://sourceforge.net/project/showfiles.php?group_id=5073

I suspect that you will likely want to add yourself to the
kgdb-bugreport mailing list.

	https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport

Mailing list is acting up; I've been having trouble posting due to
a mailserver problem; I contacted the SourceForge folks about it.

Andrew Morton has recently been taking snapshots and including them
in his mm series. It would be nice to get in "in order" and ready
for being merged up into the linux tree. When I applied the 2.6.13
patch I think I noticed some '#ifdef KGDB' code missing. I'd like 
to see the patch totally disabled by not configuring KGDB. The 
patch instructions are also a bit misleading, at least for 2.6.13;
I had to apply all of the patches in the series to avoid a lot a 
patch rejects. 

-piet

> 
> -Andi
-- 
---
piet@bluelane.com

--=-/UlZGbhnV/5HwUkiQYWX
Content-Disposition: inline
Content-Description: Attached message - Re: mm patches - what's the
	heirarchy for patches on www.kernel.org web page?
Content-Type: message/rfc822

Received: from mse2fe2.mse2.exchange.ms ([10.0.25.86]) by
	ms07.mse2.exchange.ms with Microsoft SMTPSVC(6.0.3790.1830); Thu, 20 Apr
	2006 04:06:58 -0400
Received: from p00m169.mxlogic.net ([66.179.109.169]) by
	mse2fe2.mse2.exchange.ms with Microsoft SMTPSVC(6.0.3790.1830); Thu, 20 Apr
	2006 04:06:58 -0400
Received: from unknown [65.172.181.4] (EHLO smtp.osdl.org) by
	p00m169.mxlogic.net (mxl_mta-2.14.0-12) with ESMTP id
	f1147444.2052742064.4223.p00m169.mxlogic.net (envelope-from
	<akpm@osdl.org>); Thu, 20 Apr 2006 02:06:55 -0600 (MDT)
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
	smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3K86rtH032515
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO) for
	<piet@bluelane.com>; Thu, 20 Apr 2006 01:06:53 -0700
Received: from bix (shell0.pdx.osdl.net [10.9.0.31]) by shell0.pdx.osdl.net
	(8.13.1/8.11.6) with SMTP id k3K86rQj019624 for <piet@bluelane.com>; Thu,
	20 Apr 2006 01:06:53 -0700
Date: Thu, 20 Apr 2006 01:06:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: piet@bluelane.com
Subject: Re: mm patches - what's the heirarchy for patches on
	www.kernel.org web page?
Message-Id: <20060420010605.5b0bc661.akpm@osdl.org>
In-Reply-To: <1145520207.25127.33.camel@piet2.bluelane.com>
References: <Pine.LNX.4.64.0604191444200.1841@death>
	 <20060419163247.6986a87c.akpm@osdl.org>
	 <20060419224202.3e2f99f5.akpm@osdl.org>
	 <Pine.LNX.4.64.0604200242410.3134@death>
	 <20060420004915.45cd34be.akpm@osdl.org>
	 <1145520207.25127.33.camel@piet2.bluelane.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
X-Spam: [F=0.0149253731; B=0.500(0); BMI=0.500(none); S=0.010(2006033101);
	MH=0.500(2006041910); R=0.600(s0/n0); SC=none; spf=0.500]
X-MAIL-FROM: <akpm@osdl.org>
X-SOURCE-IP: [(unknown)]
X-Brightmail-Tracker: AAAAAA==
Return-Path: akpm@osdl.org
X-OriginalArrivalTime: 20 Apr 2006 08:06:58.0190 (UTC)
	FILETIME=[6555FAE0:01C66451]
X-Evolution-Source: imap://pdelaney;auth=NTLM@ms07.mse2.exchange.ms/
Content-Transfer-Encoding: 7bit

Piet Delaney <piet@bluelane.com> wrote:
>
>  tried patching the latest stable kennel, 2.6.16.9 I thought, to
>  2.6.17.rc2 but got conflicts.

2.6.16.x is a branch, based on 2.6.16.

2.6.17-rcX is on the trunk.  The published diffs are against 2.6.16.

So you should have patched 2.6.16.


>  A few years ago Linus said he wanted to integrated the kgdb patch
>  but then stopped when he found our there were two patches. Now there
>  only seems to be one. Do you know why it's not being integrated into
>  the std linux kernel?

Nobody is doing the work to get the patches in order and merged up.  It'd
require a month or two moderately intense effort.

--=-/UlZGbhnV/5HwUkiQYWX--

