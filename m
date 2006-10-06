Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751511AbWJFLFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbWJFLFG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 07:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWJFLFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 07:05:05 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:26860 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751493AbWJFLFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 07:05:01 -0400
Subject: Re: [discuss] Re: Please pull x86-64 bug fixes
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, Andi Kleen <ak@suse.de>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0610051536590.3952@g5.osdl.org>
References: <200610051910.25418.ak@suse.de> <200610051953.23510.ak@suse.de>
	 <45255D34.804@garzik.org> <200610052142.29692.ak@suse.de>
	 <452564B9.4010209@garzik.org>
	 <Pine.LNX.4.64.0610051536590.3952@g5.osdl.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 06 Oct 2006 13:03:50 +0200
Message-Id: <1160132630.3000.98.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-05 at 15:45 -0700, Linus Torvalds wrote:
> 
> On Thu, 5 Oct 2006, Jeff Garzik wrote:
> 
> > Andi Kleen wrote:
> > > If the choice is between a secret NDA only card with dubious
> > > functionality and booting on lots of modern boards I know what to choose.
> > 
> > That's a strawman argument.  There is no need to choose.  You can clearly boot
> > on lots of modern boards with mmconfig just fine.  We just need to narrow down
> > which ones.
> 
> Jeff, _that_ is the strawman argument.
> 
> The thing is, nobody has been able to so far come up with a way to narrow 
> down which ones.
> 
> I think Andi's response was quite on the mark: if you have a patch to 
> narrow it down, please share. Until then, the fact is, we don't know 
> _how_, and you're barking up the wrong tree.


we can do a tiny bit better than the current code; some chipsets have
the address of the MMIO region stored in their config space; so we can
get to that using the old method and validate the acpi code with that.

I'm (in the background) working on collecting which chipsets have this;
it seems that at least several Intel ones do.



