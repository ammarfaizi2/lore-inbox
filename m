Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318061AbSHGLOu>; Wed, 7 Aug 2002 07:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318076AbSHGLOu>; Wed, 7 Aug 2002 07:14:50 -0400
Received: from ns.suse.de ([213.95.15.193]:48907 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318061AbSHGLOt>;
	Wed, 7 Aug 2002 07:14:49 -0400
Date: Wed, 7 Aug 2002 13:18:13 +0200
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@redhat.com>
Cc: Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: 64bit clean drivers was Re: Linux 2.4.20-pre1
Message-ID: <20020807131813.A25485@wotan.suse.de>
References: <20020807130417.A19231@wotan.suse.de> <200208071110.g77BAaH05474@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208071110.g77BAaH05474@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2002 at 07:10:36AM -0400, Alan Cox wrote:
> > dep_bool .... $CONFIG_X86_32
> > 
> > Would that be acceptable for you?  (ok that would not cover ppc32 for 
> > example, but they may have other issues with the driver) 
> 
> dep_bool doesnt have negations, bracketing or or operations. Thats why
> CML1 can't handle it but CML2 probably could have

But you can always define negative symbols (CONFIG_4GB CONFIG_32BIT CONFIG_LITTLE_ENDIAN, 
no need for !CONFIG_BIG_ENDIAN). I don't see how or should be 
needed with careful chosing of symbols.

> 
> > They will discover it when they don't find a driver for an device and
> > can then find the disabled configuration and look into fixing it
> > (for someone able to fix the driver checking the configuration should
> > be trivial) 
> 
> No they'll mail you asking where it has gone

That's fine too.

> 
> > In my opinion it is just not acceptable when the enable the driver by
> > mistake or load the wrong module and it crashes.
> 
> Thats a packaging issue for distributed prebuilt kernel trees. Also crashes
> are the only way you are going to find out what needs fixing, who wants to
> fix it and the like

I disagree. In my opinion such low standards on the kernel configuration
are not acceptable.  Things that 100% will not work should not be
visible.

-Andi
