Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268040AbUI1Ran@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268040AbUI1Ran (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 13:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268052AbUI1Ram
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 13:30:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63379 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268132AbUI1RaV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 13:30:21 -0400
Date: Tue, 28 Sep 2004 12:39:39 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Cc: Florin Andrei <florin@andrei.myip.org>,
       Nick Piggin <piggin@cyberone.com.au>, Con Kolivas <kernel@kolivas.org>
Subject: Re: excessive swapping
Message-ID: <20040928153939.GB12494@logos.cnet>
References: <1092379250.2597.14.camel@rivendell.home.local> <1094104952.4339.10.camel@rivendell.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094104952.4339.10.camel@rivendell.home.local>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florin,

You should get much better behaviour in 2.6.8-rc2-mm4 due
to Nick's kswapd "aggressiveness" fix.

Please try it!

On Wed, Sep 01, 2004 at 11:02:32PM -0700, Florin Andrei wrote:
> On Thu, 2004-08-12 at 23:40, Florin Andrei wrote:
> > I am running 2.6.8-rc4 with Ingo's voluntary preempt patch O5, on Fedora
> > 2.
> > At the same time, i'm processing some DVDs that i made - i'm extracting
> > titles from a DVD to a dedicated hard-drive, saving audio and video
> > tracks, etc with transcode-0.6.12 ( http://www.transcoding.org ). All
> > that means reading/writing from/to large files on /dev/dvd and /dev/hde
> > at high speeds.
> > The system is swapping excessively. There's no way the total size of the
> > applications exceeds the size of RAM. There's plenty of room to spare,
> > yet 16% of the 530MB of swap is used.
> 
> I am running now 2.6.8.1 with Ingo's O8 and Con Kolivas' hard swappiness
> patch (an old version, sorry). Under the same conditions described
> above, there is 0% swap usage.
> 
> The CK hard swappiness patch solved the issue for me. The system works
> without any problems whatsoever.
