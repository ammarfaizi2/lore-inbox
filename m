Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276453AbRJPRK6>; Tue, 16 Oct 2001 13:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276451AbRJPRKs>; Tue, 16 Oct 2001 13:10:48 -0400
Received: from inway106.cdi.cz ([213.151.81.106]:6528 "EHLO luxik.cdi.cz")
	by vger.kernel.org with ESMTP id <S276411AbRJPRKk>;
	Tue, 16 Oct 2001 13:10:40 -0400
Posted-Date: Tue, 16 Oct 2001 19:11:08 +0200
Date: Tue, 16 Oct 2001 19:11:08 +0200 (CEST)
From: Martin Devera <devik@cdi.cz>
To: Francois Romieu <romieu@cogenit.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: sendto syscall is slow
In-Reply-To: <20011016190233.A3347@se1.cogenit.fr>
Message-ID: <Pine.LNX.4.10.10110161909030.321-100000@luxik.cdi.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Martin Devera <devik@cdi.cz> :
> [...]
> > Are you speaking about rewriting nic driver ? Like try to drain
> > waiting packet from nic's memory while enqueuing new one ?
> 
> Partly: simply disabling Rx/Tx interrupt and checking for ack
> in buffers descriptor during hard_start_xmit. The profile for 
> loopback shows your problem is not here however. :o(

I just found that PF_SOCKET can be mmaped to improve reads.
Only I can't found docs how to use the functionality ..

