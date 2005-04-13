Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVDMI77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVDMI77 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 04:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVDMI76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 04:59:58 -0400
Received: from w241.dkm.cz ([62.24.88.241]:24234 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261262AbVDMI7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 04:59:55 -0400
Date: Wed, 13 Apr 2005 10:59:54 +0200
From: Petr Baudis <pasky@ucw.cz>
To: David Woodhouse <dwmw2@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>, git@vger.kernel.org
Subject: Re: Re: [ANNOUNCE] git-pasky-0.3
Message-ID: <20050413085954.GA13251@pasky.ji.cz>
References: <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050410024157.GE3451@pasky.ji.cz> <20050410162723.GC26537@pasky.ji.cz> <20050411015852.GI5902@pasky.ji.cz> <20050411135758.GA3524@pasky.ji.cz> <1113311256.20848.47.camel@hades.cambridge.redhat.com> <20050413094705.B1798@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050413094705.B1798@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Wed, Apr 13, 2005 at 10:47:05AM CEST, I got a letter
where Russell King <rmk+lkml@arm.linux.org.uk> told me that...
> On Tue, Apr 12, 2005 at 02:07:36PM +0100, David Woodhouse wrote:
> > I'd suggest making it [index] big-endian to make sure the LE weenies don't
> > forget to byteswap properly.
> 
> That's not a bad argument actually - especially as networking uses BE.
> (and git is about networking, right?) 8)

Theoretically, you are never supposed to share your index if you work in
fully git environment. However, I offer some "base tarballs" which have
the unpacked source as well as the .git directory, and I think you want
the index there. Of course you can always regenerate it by

	read-tree $(tree-id)

but I really don't want to (hey, dwmw got away with that too! ;-). It
forces an additional out-of-order step you need to do before making use
of your git for the first time.

The NFS argument obviously seems perfectly valid to me too.  So, FWIW,
I'm personally all for it, if someone gives me a patch.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.
