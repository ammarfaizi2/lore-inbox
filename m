Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267204AbSKPCQQ>; Fri, 15 Nov 2002 21:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267205AbSKPCQQ>; Fri, 15 Nov 2002 21:16:16 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:48304 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267204AbSKPCQP>; Fri, 15 Nov 2002 21:16:15 -0500
Subject: Re: Dead & Dying interfaces
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Wilcox <willy@debian.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021115184725.H20070@parcelfarce.linux.theplanet.co.uk>
References: <20021115184725.H20070@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Nov 2002 02:49:42 +0000
Message-Id: <1037414982.21922.22.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-15 at 18:47, Matthew Wilcox wrote:
> 
> We forgot to remove a lot of crap interfaces during 2.5 development.
> Let's start a list now so we don't forget during 2.7.
> 
> This list is a combination of interfaces which have gone during 2.5 and
> interfaces that should go during 2.7.  Think of it as a `updating your
> driver/filesystem to sane code' guide.
> 
> sleep_on, sleep_on_timeout, interruptible_sleep_on,
> 	interruptible_sleep_on_timeout
>  -> use wait_event interfaces

We need to fix wait_event first, probably to do event variables of some
kind (wait_nonzero_interruptible() etc).

get_cpu is the wrong thing in several places too

