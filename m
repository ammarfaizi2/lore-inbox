Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314458AbSFISwg>; Sun, 9 Jun 2002 14:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314475AbSFISwf>; Sun, 9 Jun 2002 14:52:35 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:22462 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S314458AbSFISwe>; Sun, 9 Jun 2002 14:52:34 -0400
Date: Sun, 9 Jun 2002 20:50:54 +0200
From: Andi Kleen <ak@muc.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Andi Kleen <ak@muc.de>, "David S. Miller" <davem@redhat.com>, lord@sgi.com,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org, bcrl@redhat.com
Subject: Re: [RFC] 4KB stack + irq stack for x86
Message-ID: <20020609205054.A1329@averell>
In-Reply-To: <20020604225539.F9111@redhat.com> <1023315323.17160.522.camel@jen.americas.sgi.com> <20020605183152.H4697@redhat.com> <20020605.161342.71552259.davem@redhat.com> <m3d6v5mcm2.fsf@averell.firstfloor.org> <20020602155202.F219@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 02, 2002 at 05:52:02PM +0200, Pavel Machek wrote:
> Hi!
> 
> > The scenario Steve outlined was rather optimistic - more pessimistic
> > case would be e.g:
> > you run NBD which calls the network stack with an complex file system on top
> > of it called by something else complex that does a GFP_KERNEL alloc and VM 
> > wants to flush a page via the NBD file system - 
> 
> Actually, at this point we are dead anyway because of locks in NBD. NBD should
> be carefull to use GFP_NOIO.

Reread what I wrote. It does not involve NBD recursing.

-Andi
