Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261513AbSIZV3W>; Thu, 26 Sep 2002 17:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261514AbSIZV3W>; Thu, 26 Sep 2002 17:29:22 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:32487 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S261513AbSIZV3V>; Thu, 26 Sep 2002 17:29:21 -0400
Date: Thu, 26 Sep 2002 22:58:47 +0200
From: Richard Zidlicky <rz@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] fix ide-iops for big endian archs
Message-ID: <20020926225847.B2242@linux-m68k.org>
References: <1033052967.1348.30.camel@irongate.swansea.linux.org.uk> <20020926151414.26040@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020926151414.26040@192.168.4.1>; from benh@kernel.crashing.org on Thu, Sep 26, 2002 at 05:14:14PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 05:14:14PM +0200, Benjamin Herrenschmidt wrote:
> >On Wed, 2002-09-25 at 13:32, Benjamin Herrenschmidt wrote:
> >> I enclosed the patch as an attachement too in case the mailer screws
> >> it up...
> >
> >Please do one thing. For the stuff that needs weird powerpcisms put all
> >the seperate stuff in one block with its own copy of the static inlines
> >so we dont have in ifdef in half the functions in the file
> 
> This is _NOT_ a weird PowerPC'ism !!!
> 
> It's just a matter of use the proper operation, that is "insw/outsw"
> instead of trying to re-implement it with a loop of basic inw/outw,
> which is wrong for _any_ BE arch (except maybe weird m68k'ism where
> IDE is wired the wrong way around)

to put it a bit more precise, this is bus endianness, nothing to 
do with arch endianness.

Richard
