Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264372AbTKURJp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 12:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264373AbTKURJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 12:09:45 -0500
Received: from the-penguin.otak.com ([65.37.126.18]:3712 "EHLO
	the-penguin.otak.com") by vger.kernel.org with ESMTP
	id S264372AbTKURJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 12:09:43 -0500
Date: Fri, 21 Nov 2003 09:09:33 -0800
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Opps on boot 2.6.0-pre9-mm4
Message-ID: <20031121170933.GA1269@the-penguin.otak.com>
References: <20031120193318.GA5578@the-penguin.otak.com> <20031120131945.3cd35911.akpm@osdl.org> <20031120233006.GA1331@the-penguin.otak.com> <20031120160601.6b1fbd53.akpm@osdl.org> <20031120210953.GA25417@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031120210953.GA25417@neo.rr.com>
X-Operating-System: Linux 2.6.0-test9-mm4 on an i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Belay [ambx1@neo.rr.com] wrote:
> On Thu, Nov 20, 2003 at 04:06:01PM -0800, Andrew Morton wrote:
> > Lawrence Walton <lawrence@the-penguin.otak.com> wrote:
> > >
> > > > Looks like it died inside the machine's BIOS.
> > > >
> > > > Please try reverting the three pnp patches:
> > > >
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm4/broken-out/pnp-fix-3.patch
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm4/broken-out/pnp-fix-2.patch
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm4/broken-out/pnp-fix-1.patch
> > > >
> > > > and let us know?
> > > >
> > > I reverted these and it works great!
> > >
> > >
> > >
> > > > - Upgrade the bios
> > > The bios is the latest so updating it would not of been a option.
> > >
> >
> > OK, thanks.   Adam, those pnp patches are suspect...
> 
> Hmm, well it couldn't be patch 3 because it relates to isapnp.  Patch
> 1 is the only patch that changes the PnPBIOS calls, and it has been
> known to fix problems for some systems.  Also it does what the actual
> specifications recommend.  You may just have a buggy system that's
> triggered by the static resource calls.  If so, we could use dynamic
> instead resources when the DMI scan matches with this system.  Patch
> 2 provides an option to disable the PnPBIOS proc interface, but it
> should not affect PnPBIOS calls.
> 
> Lawrence, could you please test this again, only this time excluding
> patch 1 and no others.  If that doesn't work try excluding patch 2.
> 
> Thanks,
> Adam
> 
> P.S.

Adam this worked great too. 
My guess is that this board is a little different.
It's a Asus A7V333 with fireiwire and the raid.


-- 
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://www.otak-k.com/~lawrence/
--------------------------------------
- - - - - - O t a k  i n c . - - - - - 


