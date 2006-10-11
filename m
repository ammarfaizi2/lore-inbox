Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965193AbWJKSoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965193AbWJKSoJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 14:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965224AbWJKSoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 14:44:08 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:63423 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S965193AbWJKSoF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 14:44:05 -0400
Subject: Re: [RFC] Avoid PIT SMP lockups
From: john stultz <johnstul@us.ibm.com>
To: caglar@pardus.org.tr, kraxel@suse.de
Cc: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200610112137.01160.caglar@pardus.org.tr>
References: <1160170736.6140.31.camel@localhost.localdomain>
	 <200610111349.32231.caglar@pardus.org.tr>
	 <1160589556.5973.1.camel@localhost.localdomain>
	 <200610112137.01160.caglar@pardus.org.tr>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Oct 2006 11:43:55 -0700
Message-Id: <1160592235.5973.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-11 at 21:37 +0300, S.Çağlar Onur wrote:
> 11 Eki 2006 Çar 20:59 tarihinde, john stultz şunları yazmıştı: 
> > > Yep, [1] here is whole screen and used config, and as andi suggested i
> > > recompiled this kernel [pure vanilla 2.6.18] from scratch.
> > >
> > > [1] http://cekirdek.pardus.org.tr/~caglar/2.6.18/
> >
> > Huh.. that's an odd trace.  Looks like the alternative code is involved.
> >
> > Mind booting w/ "noreplacement" to see if that avoids it?
> 
> Booting with "noreplacement" solved panics (i tried booting 10 times with both 
> kernel) for both vanilla one and yours patch included one.

Hey Gerd,
	Looks like the smp replacements code in 2.6.18 is breaking with vmware.
I'm guessing we're taking an interrupt while apply_replacements is
running. Any ideas?


> By the way i just realize, panic occurs between
> 
> Checking if this processor honours the WP bit even in supervisor mode... Ok.
> 
> and
> 
> Calibrating delay using timer specific routine.. xxxxx BogoMIPS (lpj=xxxxx)
> 
> lines, and system waits there about 5 sec. maybe more (no matter if it panics 
> or continues to boot somehow)

S.Çağlar: Didn't follow this bit at all. Could you explain a bit more?

thanks
-john


