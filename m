Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311884AbSDPTBI>; Tue, 16 Apr 2002 15:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSDPTBH>; Tue, 16 Apr 2002 15:01:07 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46859 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S311884AbSDPTBH>; Tue, 16 Apr 2002 15:01:07 -0400
Date: Tue, 16 Apr 2002 11:59:20 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "David S. Miller" <davem@redhat.com>, <haveblue@us.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix ips driver compile problems
In-Reply-To: <E16xXia-0000Zb-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0204161158190.1340-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 16 Apr 2002, Alan Cox wrote:
> 
> In which case can you do it so that virt_to_bus() being exposed requires
> the user selects
> 
> CONFIG_UNPORTED_CRAP_WORKAROUNDS 

On by default on x86 ;)

> or similar - so that we can find them, and that can't be selected on non
> x86 ?

Absolutely. The 2.5.8 headers right now expose the old virt_to_bus() 
stuff, but only on x86.  Other architectures will error the same way 
they've done since the bio stuff was updated.

		Linus

