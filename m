Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131524AbRCXAr5>; Fri, 23 Mar 2001 19:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131528AbRCXArt>; Fri, 23 Mar 2001 19:47:49 -0500
Received: from monza.monza.org ([209.102.105.34]:53508 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S131524AbRCXAr3>;
	Fri, 23 Mar 2001 19:47:29 -0500
Date: Fri, 23 Mar 2001 16:46:27 -0800
From: Tim Wright <timw@splhi.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
Message-ID: <20010323164627.C2534@kochanski.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
In-Reply-To: <UTC200103231829.TAA06442.aeb@vlet.cwi.nl> <E14gWSN-0005CQ-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14gWSN-0005CQ-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Mar 23, 2001 at 06:38:37PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2001 at 06:38:37PM +0000, Alan Cox wrote:
> > infinite storage. After all, earlier Unix flavours did not need
> > an OOM killer either, and my editor was not killed under Unix V6
> > on 64k when I started some other process.
> 
> You were lucky. Its quite possible for V6 to kill processes when you run out
> of swap
> 

It was actually worse than that. Grab your copy of "Lions", and check lines
4375-4377 in function xswap(). A failure to allocate space in the swapmap
caused a panic. Same problem in xalloc().

Tim

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
