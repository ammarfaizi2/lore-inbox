Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVBNXqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVBNXqt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 18:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVBNXqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 18:46:49 -0500
Received: from gprs215-140.eurotel.cz ([160.218.215.140]:6802 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261290AbVBNXqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 18:46:36 -0500
Date: Tue, 15 Feb 2005 00:41:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, Bernard Blackham <bernard@blackham.com.au>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Address lots of pending pm_message_t changes
Message-ID: <20050214234151.GA2134@elf.ucw.cz>
References: <1108359808.12611.37.camel@desktop.cunningham.myip.net.au> <20050214213400.GF12235@elf.ucw.cz> <20050214134658.324076c9.akpm@osdl.org> <1108418226.12611.75.camel@desktop.cunningham.myip.net.au> <20050214220459.GM12235@elf.ucw.cz> <1108418990.12611.86.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108418990.12611.86.camel@desktop.cunningham.myip.net.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > Andrew, if you get one big patch doing only type-safety (u32 ->
> > > > >  pm_message_t, no code changes), would you still take it this late? I
> > > > >  promise it is not going to break anything... It would help merge after
> > > > >  2.6.11 quite a lot...
> > > > 
> > > > Problem is, such a megapatch causes grief for all those people who maintain
> > > > their own trees.  It would be best, please, to split it into 10-20 bits and
> > > > send the USB parts to Greg and the SCSI bits to James, etc.
> > > 
> > > Okay; I can do that if everyone is happy with the thing as a whole.
> > > Andrew, can I get your answer on Pavel's question - shall I just include
> > > the u32->pm_message_t part?
> > 
> > Yes, I believe it is too late to do anything than u32->pm_message_t
> > conversion that changes no code...
> 
> I guess I'm wrong then - I thought the other changes avoided compilation
> errors.

Well, yes, if you switch pm_message_t into struct. But we are not yet
ready to do that... it is going to be typedefed to u32 for 2.6.11...

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
