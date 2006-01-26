Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWAZAGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWAZAGP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 19:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWAZAGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 19:06:14 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:40853
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751140AbWAZAGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 19:06:12 -0500
Date: Wed, 25 Jan 2006 16:04:30 -0800 (PST)
Message-Id: <20060125.160430.94334986.davem@davemloft.net>
To: paulus@samba.org
Cc: mita@miraclelinux.com, linux-kernel@vger.kernel.org,
       linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, spyro@f2s.com,
       dhowells@redhat.com, linuxppc-dev@ozlabs.org, gerg@uclinux.org,
       sparclinux@vger.kernel.org, uclinux-v850@lsi.nec.co.jp,
       torvalds@osdl.org, ysato@users.sourceforge.jp, takata@linux-m32r.org,
       linuxsh-shmedia-dev@lists.sourceforge.net, linux-m68k@vger.kernel.org,
       ink@jurassic.park.msu.ru, rth@twiddle.net, chris@zankel.net,
       dev-etrax@axis.com, ultralinux@vger.kernel.org, ak@suse.de,
       linuxsh-dev@lists.sourceforge.net, linux390@de.ibm.com,
       rmk@arm.linux.org.uk, parisc-linux@parisc-linux.org
Subject: Re: [PATCH 5/6] fix warning on test_ti_thread_flag()
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <17367.64370.844350.972910@cargo.ozlabs.ibm.com>
References: <20060125112625.GA18584@miraclelinux.com>
	<20060125113446.GF18584@miraclelinux.com>
	<17367.64370.844350.972910@cargo.ozlabs.ibm.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Mackerras <paulus@samba.org>
Date: Thu, 26 Jan 2006 09:28:02 +1100

> Akinobu Mita writes:
> 
> > If the arechitecture is
> > - BITS_PER_LONG == 64
> > - struct thread_info.flag 32 is bits
> > - second argument of test_bit() was void *
> > 
> > Then compiler print error message on test_ti_thread_flags()
> > in include/linux/thread_info.h
> 
> And correctly so.  The correct fix is to make thread_info.flag an
> unsigned long.  This patch is NAKed.

I agree.
