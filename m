Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135239AbREFIoL>; Sun, 6 May 2001 04:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135240AbREFIn5>; Sun, 6 May 2001 04:43:57 -0400
Received: from ns.suse.de ([213.95.15.193]:36113 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S135239AbREFInF>;
	Sun, 6 May 2001 04:43:05 -0400
Date: Sun, 6 May 2001 10:40:37 +0200
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Ben Greear <greearb@candelatech.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@muc.de>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] arp_filter patch for 2.4.4 kernel.
Message-ID: <20010506104037.C29403@gruyere.muc.suse.de>
In-Reply-To: <3AF4720F.35574FDD@candelatech.com> <15092.32371.139915.110859@pizda.ninka.net> <3AF49617.1B3C48AF@candelatech.com> <15092.37426.648280.631914@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15092.37426.648280.631914@pizda.ninka.net>; from davem@redhat.com on Sat, May 05, 2001 at 04:52:18PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2001 at 04:52:18PM -0700, David S. Miller wrote:
>  > I have a setup that should be able to test some netfilter rules
>  > if have some you want me to try....
> 
> I'd be interested in seeing netfilter rules or a new netfilter
> kernel module which would do arpfilter as well.

I don't think it's a good idea. You either need a lot of hooks in the
arp input path for all the different cases or you would need to replicate
a lot of the arp.c logic into that netfilter module. Both not good.
IMHO it's better to just control replies via the routing table,
which already has all kinds of fancy mechanisms for it. In addition I haven't
seen a setup yet that couldn't be handled by arpfilter and the routing
table, it seems to be flexible enough for all practical purposes.

-Andi

