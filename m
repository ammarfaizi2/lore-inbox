Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261471AbTCYGWL>; Tue, 25 Mar 2003 01:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261472AbTCYGWL>; Tue, 25 Mar 2003 01:22:11 -0500
Received: from dp.samba.org ([66.70.73.150]:58058 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261471AbTCYGWK>;
	Tue, 25 Mar 2003 01:22:10 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: John Levon <levon@movementarian.org>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       zwane@holomorphy.com
Subject: Re: [PATCH] module load notification try 2 
In-reply-to: Your message of "Tue, 25 Mar 2003 01:15:25 -0000."
             <20030325011525.GA92370@compsoc.man.ac.uk> 
Date: Tue, 25 Mar 2003 15:01:47 +1100
Message-Id: <20030325063320.89B832C05E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030325011525.GA92370@compsoc.man.ac.uk> you write:
> > Otherwise there's no way to sanely use them without wrapping in #ifdef
> 
> Well, "if (err && err != -ENOSYS)". The relative sanity of that is
> debatable. I don't care either way, hence the coin toss.

OK, well, I have an opinion and it's the other one. 8)

> > Hmm, yes, you need to use your own protection around
> > notifier_chain_register and notifier_call_chain.  Wierd, because
> > notifier.c does its own locking for register and unregister, but not
> > for calling, which AFAICT makes it useless...
> 
> I mentioned about this some time ago on lkml to massive indifference.

Yeah, it's a PITA.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
