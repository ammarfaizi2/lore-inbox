Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266169AbUGaQUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266169AbUGaQUo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 12:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267967AbUGaQUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 12:20:44 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:49159 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S266169AbUGaQUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 12:20:32 -0400
Date: Sat, 31 Jul 2004 18:12:34 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, greearb@candelatech.com,
       akpm@osdl.org, alan@redhat.com, jgarzik@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: VLAN support for 3c59x/3c90x
Message-ID: <20040731161234.GA27388@alpha.home.local>
References: <20040730121004.GA21305@alpha.home.local> <E1BqkzY-0003mK-00@gondolin.me.apana.org.au> <20040731083308.GA24496@alpha.home.local> <410B67B1.4080906@pobox.com> <20040731101152.GG1545@alpha.home.local> <410BC32F.7050107@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <410BC32F.7050107@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2004 at 12:05:03PM -0400, Jeff Garzik wrote:
> >Ok, sorry, I've just checked, they are 6. But I incidentely used the 
> >feature
> >on 2 of them (dl2k and starfire). But more drivers still have the
> >'static int mtu=1500' preceeded by a comment stating "allow the user to 
> >change
> >the mtu". Why is it not a #define then, if nobody can change it anymore ?
> 
> People can change it all the time with ifconfig.

no, they change dev->mtu, not the 'static' mtu. I think it has been
inherited from the old days without MODULE_PARM.

> >Jeff, do you know the absolute hardware limit on the tulip ? I've seen 
> >the
> 
> It depends on the tulip.
> 
> Look at Donald Becker's tulip.c for reference, it has full ->change_mtu 
> support (as does 3c59x.c I believe).

ok thanks, I'll look at this.

Regards,
Willy

