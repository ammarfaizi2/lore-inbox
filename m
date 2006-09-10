Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbWIJRTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWIJRTe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 13:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWIJRTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 13:19:34 -0400
Received: from outbound-mail-48.bluehost.com ([70.96.188.17]:34964 "HELO
	outbound-mail-48.bluehost.com") by vger.kernel.org with SMTP
	id S932192AbWIJRTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 13:19:32 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Opinion on ordering of writel vs. stores to RAM
Date: Sun, 10 Sep 2006 10:19:11 -0700
User-Agent: KMail/1.9.3
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, segher@kernel.crashing.org,
       davem@davemloft.net
References: <17666.8433.533221.866510@cargo.ozlabs.ibm.com> <1157786600.31071.166.camel@localhost.localdomain> <1157814591.6877.29.camel@localhost.localdomain>
In-Reply-To: <1157814591.6877.29.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609101019.11608.jbarnes@virtuousgeek.org>
X-Identified-User: {642:box128.bluehost.com:virtuous:virtuousgeek.org} {sentby:smtp auth 67.169.58.76 authed with jbarnes@virtuousgeek.org}
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, September 09, 2006 8:09 am, Alan Cox wrote:
> Ar Sad, 2006-09-09 am 17:23 +1000, ysgrifennodd Benjamin 
Herrenschmidt:
> > The problem is that very few people have any clear idea of what
> > mmiowb is :) In fact, what you described is not the definition of
> > mmiowb according to Jesse
>
> Some of us talked a little about this at Linux Kongress and one
> suggestion so people did understand it was
>
> 	spin_lock_io();
> 	spin_unlock_io();
>
> so that it can be expressed not as a weird barrier op but as part of
> the locking.

That's what IRIX had.  It would let us get rid of mmiowb and avoid doing 
a full sync in writeX, so may be the best option.

Jesse
