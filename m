Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137110AbREKLPN>; Fri, 11 May 2001 07:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137107AbREKLO4>; Fri, 11 May 2001 07:14:56 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:40975 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S137108AbREKLOm>;
	Fri, 11 May 2001 07:14:42 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Andi Kleen <ak@suse.de>
Date: Fri, 11 May 2001 13:08:56 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Source code compatibility in Stable series????
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org,
        davem@redhat.com
X-mailer: Pegasus Mail v3.40
Message-ID: <29907B06E7C@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 May 01 at 12:32, Andi Kleen wrote:
> On Fri, May 11, 2001 at 12:21:59PM +0000, Petr Vandrovec wrote:
> > When I was updating VMware's vmnet, I decided to use
> > 
> > #ifdef skb_shinfo
> 
> Yes I forgot that RedHat already shipped it :-(

Not only that RedHat shipped it, but thousands of people used Alan's
patches since 25th February. So you cannot check kernel version for >=2.4.4.
 
> > This gives you maximal backward compatibility, as all public zerocopy
> > patches contain this macro. Only thing is that Dave has to remember
> > that when he turns skb_shinfo into inline function, an identity #define have
> > to be added.
> 
> No such guarantee for binary only software ;)

vmnet is GPLed software, if you did not notice ;-) Fortunately change
went into Alan tree first, so I noticed long before 2.4.4 came out. Although
it took nonzero effort to persuade others that it will go into Linus's 2.4.x
even if it breaks API. They did not trust me that source compatibility 
in stable series is only a wish.
                                                        Petr Vandrovec
                                                        vandrove@vc.cvut.cz
