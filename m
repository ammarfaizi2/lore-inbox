Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268323AbUIWIDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268323AbUIWIDO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 04:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268325AbUIWIDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 04:03:14 -0400
Received: from smtp-vbr3.xs4all.nl ([194.109.24.23]:32519 "EHLO
	smtp-vbr3.xs4all.nl") by vger.kernel.org with ESMTP id S268323AbUIWIDI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 04:03:08 -0400
Date: Thu, 23 Sep 2004 10:03:07 +0200
From: Koos Vriezen <koos.vriezen@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: Javascript bug with 2.6.8.1
Message-ID: <20040923080306.GA33907@xs4all.nl>
References: <20040922181800.GA20060@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040922181800.GA20060@xs4all.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2004 at 08:18:00PM +0200, Koos Vriezen wrote:
> sledgedog wrote:
> > hi,
> > the error occurs with any navigator and only with the kernel 2.6.8
> > the javascript on an https interactive site of a bank won't
> > display the full page and hang in the middle .
> > But with the kernel 2.6.7 on same machine with same
> > programs there is no problem the full page is displayed.
> > I can reproduce the problem on different machines.
> > I'd like to be personally CC'ed the answers/comments posted to the
> > list in response to my posting.
> 
> Coincidence, I was bashing the #debian channel today with this problem
> too. Used 'lynx -source www.iu.nl/nl' as testcase. After ignoring 
> "it's ECN, you moron" and some tcpdump analyses, turned out to be 2.6.8.1
> related. I really hope someone explains in this thread if 2.6.8.1 needs 
> some extra configuring compared to 2.6.7 or either point to a patch or
> so.

In case it's not clear what this is about, it about lynx not being able
to dump the whole page but hanging in the middle somewhere. Where seems
to be at the same point, though changing the MTU changes that.
With 2.6.7, lynx dumps this page, as it seems, in one stroke. Just now,
I tested it with 2.6.9-rc2-bk8 and I do get the whole page, but it hangs
for half a second or so at the same point and then continues the rest of
the page.
I found this problem after a report that our squid proxy wasn't able to
get some web pages. The reported page was on the service provider in the
above link. So it's not a lynx thingy. Even tried it with netcat, same
result. Also different linux-2.6.8.1 boxes (one dual P200MMX, celeron700,
PIV-2.4GHz) and 2.6.9-rc2-bk8 only on celeron700, with different network
adaptors (eepro100, ne2k_pci, ne).

> Koos
