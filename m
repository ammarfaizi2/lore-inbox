Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317862AbSHLLEW>; Mon, 12 Aug 2002 07:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317864AbSHLLEW>; Mon, 12 Aug 2002 07:04:22 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:10745 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317862AbSHLLEV>; Mon, 12 Aug 2002 07:04:21 -0400
Subject: Re: [patch] tls-2.5.31-C3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       julliard@winehq.com, ldb@ldb.ods.org
In-Reply-To: <Pine.LNX.4.44.0208121454580.14271-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0208121454580.14271-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 12 Aug 2002 13:29:27 +0100
Message-Id: <1029155367.16421.163.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-12 at 13:55, Ingo Molnar wrote:
> 
> On 12 Aug 2002, Alan Cox wrote:
> 
> > > ugh, we do Linux interrupts while in the APM BIOS?
> > 
> > We have to. Most APM bios expects interrupts to be happening. In
> > pre-emptive mode we may well even be switching to/from APM BIOS code in
> > 2.5 at the moment. I've not looked into that.
> 
> i think that since we hold the APM spinlock (do we always, when calling
> into the APM BIOS?), we should not preempt any APM BIOS code.

Looking at the 2.5.29 tree I have handy here there is no APM spinlock. I
don't have 2.5.30/31 unpacked to check those



