Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265193AbUELTtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265193AbUELTtm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 15:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265198AbUELTtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 15:49:42 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:4559 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265193AbUELTtk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 15:49:40 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 12 May 2004 12:49:38 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Ingo Molnar <mingo@elte.hu>
cc: Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>
Subject: Re: MSEC_TO_JIFFIES is messed up...
In-Reply-To: <20040512193349.GA14936@elte.hu>
Message-ID: <Pine.LNX.4.58.0405121247011.11950@bigblue.dev.mdolabs.com>
References: <20040512020700.6f6aa61f.akpm@osdl.org> <20040512181903.GG13421@kroah.com>
 <40A26FFA.4030701@pobox.com> <20040512193349.GA14936@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2004, Ingo Molnar wrote:

> 
> * Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> > >Woah, that's new.  And wrong.  The code in include/asm-i386/param.h that
> > >says:
> > >	# define JIFFIES_TO_MSEC(x)     (x)
> > >	# define MSEC_TO_JIFFIES(x)     (x)
> > >
> > >Is not correct.  Look at kernel/sched.c for verification of this :)
> > 
> > 
> > Yes, that is _massively_ broken.
> 
> why is it wrong?

For HZ == 1000 it's fine, even if it'd better to explicitly make it HZ 
dependent and let the compiler to discard them.



- Davide

