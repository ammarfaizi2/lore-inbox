Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262367AbUK3WgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbUK3WgB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 17:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbUK3WgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 17:36:01 -0500
Received: from canuck.infradead.org ([205.233.218.70]:25865 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262367AbUK3Wew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 17:34:52 -0500
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alexandre Oliva <aoliva@redhat.com>, dhowells <dhowells@redhat.com>,
       Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       Matthew Wilcox <matthew@wil.cx>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
In-Reply-To: <Pine.LNX.4.58.0411301423030.22796@ppc970.osdl.org>
References: <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org>
	 <19865.1101395592@redhat.com>
	 <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
	 <1101406661.8191.9390.camel@hades.cambridge.redhat.com>
	 <20041127032403.GB10536@kroah.com>
	 <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
	 <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <8219.1101828816@redhat.com>
	 <Pine.LNX.4.58.0411300744120.22796@ppc970.osdl.org>
	 <ormzwzrrmy.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <Pine.LNX.4.58.0411301249590.22796@ppc970.osdl.org>
	 <orekibrpmn.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <Pine.LNX.4.58.0411301423030.22796@ppc970.osdl.org>
Content-Type: text/plain
Date: Tue, 30 Nov 2004 22:34:20 +0000
Message-Id: <1101854061.4574.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-30 at 14:25 -0800, Linus Torvalds wrote:
> 
> On Tue, 30 Nov 2004, Alexandre Oliva wrote:
> 
> > >  (a) it can't break anything (ie the old location still includes the new 
> > >      one, exactly the same way)
> > 
> > You mean it can't break anything in a kernel build, or it can't break
> > anything except for userland apps that abused kernel headers and used
> > to get away with that?
> 
> It can't break userland either.

That depends on your definition of 'break'. It should prevent abuse.

To pick a specific example, since you like them: where userland programs
are including atomic.h, and hence writing programs which don't compile
on some architectures, and which compile on others but silently give
non-atomic results, it's perfectly acceptable and indeed advisable to
prevent compilation across the board.

Some people might call that breakage; I don't.

-- 
dwmw2

