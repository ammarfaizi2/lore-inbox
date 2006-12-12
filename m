Return-Path: <linux-kernel-owner+w=401wt.eu-S1750795AbWLLAmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWLLAmY (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 19:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWLLAmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 19:42:24 -0500
Received: from ns1.suse.de ([195.135.220.2]:38600 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792AbWLLAmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 19:42:23 -0500
From: Neil Brown <neilb@suse.de>
To: Jiri Kosina <jikos@jikos.cz>
Date: Tue, 12 Dec 2006 11:42:24 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17789.64240.879603.161637@cse.unsw.edu.au>
Cc: Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, mingo@redhat.com,
       linux-raid@vger.kernel.org
Subject: Re: oops on 2.6.19-rc6-mm2: deref of 0x28 at permission+0x7
In-Reply-To: message from Jiri Kosina on Monday December 11
References: <457A0F4C.9060601@gmail.com>
	<Pine.LNX.4.64.0612102027350.1665@twin.jikos.cz>
	<17788.48732.53210.631230@cse.unsw.edu.au>
	<Pine.LNX.4.64.0612111034480.1665@twin.jikos.cz>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday December 11, jikos@jikos.cz wrote:
> On Mon, 11 Dec 2006, Neil Brown wrote:
> 
> > > this nash thing is exactly the command which triggers a bit different 
> > > oops in my case. On my side, the oops is fully reproducible. If you 
> > > manage to make your case also reproducible, could you please try to 
> > > revert md-change-lifetime-rules-for-md-devices.patch? This made the 
> > > oops vanish in my case. I think Neil is working on it.
> > Trying to work on it - not making a lot of progress.  I find it hard to 
> > see how anything in md can cause the inode for a block-device file to 
> > disappear... It is a bit of a long-shot, but this patch might change 
> > things.  It changes the order in which things are de-allocated. Jiri and 
> > Jiri: would either of both of you see if you can reproduce the bug with 
> > this patch on 2.6.19-rc6-mm2 ???
> 
> Hi Neil,
> 
> sorry to say that, but it's still there after applying your patch.

Not a big surprise, but thanks a lot for testing.  I think I'm going
to have to try harder to duplicate it myself.

If I remember rightly you are using FC - which version exactly?  (I've
never installed FC before so this is going to be learning experience).

And you have no MD arrays at all - is that correct?

And you compile your own kernel.  Is it monolithic, or are you using
modules?  Do you boot with an initrd or just the kernel?

I'd like to duplicate your installation as closely as possible, so any
relevant details or recipes would be greatly appreciated.

Thanks,

NeilBrown
