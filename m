Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276361AbRJPP7J>; Tue, 16 Oct 2001 11:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276364AbRJPP6t>; Tue, 16 Oct 2001 11:58:49 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:62860 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S276361AbRJPP6r>;
	Tue, 16 Oct 2001 11:58:47 -0400
Date: Tue, 16 Oct 2001 17:59:08 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Martin Devera <devik@cdi.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sendto syscall is slow
Message-ID: <20011016175908.A2258@se1.cogenit.fr>
In-Reply-To: <Pine.LNX.4.33.0110151105400.22170-100000@shell1.aracnet.com> <Pine.LNX.4.10.10110161438140.13894-100000@luxik.cdi.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10110161438140.13894-100000@luxik.cdi.cz>; from devik@cdi.cz on Tue, Oct 16, 2001 at 02:45:47PM +0200
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Devera <devik@cdi.cz> :
[sendto/recv profile]
> Is there any faster way to force raw packets to kernel ? I need
> to push qos discipline to its edge but I can't because send
> syscall is bottleneck.
> Is it possible to tx multiple packets in sinhle call or should
> I extend kernel myself for this testing purpose ?

Do you have the same profile for sendto when Rx/Tx isn't short 
connected ?
You may consider polling for Tx/Rx completion in the Tx path at the
driver level. If your cpu isn't too much powered it will make
a difference.

-- 
Ueimor
