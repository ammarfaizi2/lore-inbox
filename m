Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbTIXNN5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 09:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbTIXNN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 09:13:57 -0400
Received: from cpc1-cwma1-5-0-cust4.swan.cable.ntl.com ([80.5.120.4]:38863
	"EHLO dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261346AbTIXNND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 09:13:03 -0400
Subject: Re: log-buf-len dynamic
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Larry McVoy <lm@bitmover.com>
Cc: Rik van Riel <riel@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
       andrea@kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
In-Reply-To: <20030924034552.GB7887@work.bitmover.com>
References: <20030924031602.GA7887@work.bitmover.com>
	 <Pine.LNX.4.44.0309232327490.15940-100000@chimarrao.boston.redhat.com>
	 <20030924034552.GB7887@work.bitmover.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1064408978.13459.34.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Wed, 24 Sep 2003 14:09:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-09-24 at 04:45, Larry McVoy wrote:
> Oh, I agree.  The problem space changes and you have to move with it.  
> I was just pointing out that by not learning from others you put yourself
> at a disadvantage.  There are a lot of bright minds in the Linux space,
> there is no question of that.  But they would do so much better if they
> understood the past.  The past holds a lot of information, ignoring it
> is a disadvantage.

It isnt just sizes. As the size has risen rapidly the disk data rates
have increased pretty well (factor of about 100 over an MFM disk 386)
but the seek time has shifted by a factor of 10. This has a huge impact
on the whole basic theory of things like paging in applications versus
doing a streaming preload of the code/data.

It also has a big impact on how swap is managed - it is pretty much as
cheap now to swap out 2Mb as 4K


