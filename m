Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268095AbUIKK7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268095AbUIKK7c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 06:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268097AbUIKK7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 06:59:32 -0400
Received: from home.regit.org ([82.226.29.74]:37636 "EHLO home.regit.org")
	by vger.kernel.org with ESMTP id S268095AbUIKK7a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 06:59:30 -0400
Subject: Re: 2.6.9-rc1-mm4 : typo in include/linux/hardirq.h ?
From: Eric Leblond <regit@inl.fr>
Reply-To: regit@inl.fr
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200409110641.53689.gene.heskett@verizon.net>
References: <1094898290.4533.5.camel@porky>
	 <200409110641.53689.gene.heskett@verizon.net>
Content-Type: text/plain
Message-Id: <1094900313.4533.16.camel@porky>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 11 Sep 2004 12:58:33 +0200
Content-Transfer-Encoding: 7bit
X-Spam-Score: (----) -4.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-09-11 at 12:41, Gene Heskett wrote:
> On Saturday 11 September 2004 06:24, Eric Leblond wrote:
> >Hi,
> >
> >On my i386 computer, at line 5 of include/linux/hardirq.h we can
> > read : #ifdef CONFIG_PREEPT
> 
> That prompted me to go take a look at my .config in that dir, but I'm 
> correct.  Perhaps you have a nilmerg?

I've looked at the mm diff :
http://www.kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%2Fpeople%2Fakpm%2Fpatches%2F2.6%2F2.6.9-rc1%2F2.6.9-rc1-mm4%2F2.6.9-rc1-mm4.bz2;z=2689

there's a trace of this problem...

I also get a kernel source from scratch, with the following command :
tar jxf linux-2.6.8.1.tar.bz2
cd linux-2.6.8.1
bunzip2 -c ~/patch-2.6.9-rc1.bz2 | patch -p1
bunzip2 -c ~/2.6.9-rc1-mm4.bz2 | patch -p1

the typo is at its place.

BR,
-- 
Eric Leblond <eric@regit.org>
NuFW, Now User Filtering Works : http://www.nufw.org

