Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263322AbUDEVvk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbUDEVtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:49:04 -0400
Received: from atlas.pnl.gov ([130.20.248.194]:16047 "EHLO atlas.pnl.gov")
	by vger.kernel.org with ESMTP id S263301AbUDEVpL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:45:11 -0400
Date: Mon, 05 Apr 2004 14:45:37 -0700
From: Kevin Fox <Kevin.Fox@pnl.gov>
Subject: Re: kernel stack challenge
In-reply-to: <20040405213026.37258.qmail@web40512.mail.yahoo.com>
To: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Cc: Timothy Miller <miller@techsource.com>, John Stoffel <stoffel@lucent.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Message-id: <1081201537.6361.8.camel@nightmare>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7)
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <20040405213026.37258.qmail@web40512.mail.yahoo.com>
X-OriginalArrivalTime: 05 Apr 2004 21:45:07.0773 (UTC)
 FILETIME=[434226D0:01C41B57]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-04-05 at 14:30, Sergiy Lozovsky wrote:
> --- Timothy Miller <miller@techsource.com> wrote:
> > 
> > 
> > Sergiy Lozovsky wrote:
> > 
> > > 
> > > 
> > > All LISP errors are incapsulated within LISP VM.
> > >  
> > 
> > 
> > A LISP VM is a big, giant, bloated.... *CHOKE*
> > *COUGH* *SPUTTER* 
> > *SUFFOCATE* ... thing which SHOULD NEVER be in the
> > kernel.
> 
> It is a smallest interpreter (of all purpose language)
> I was able to find. My guess is that you refer to the
> Common Lisp. it is huge and I don't use it.
> 

How about BF? ;)

I would think something like forth might be a better fit then lisp.

> > 
> > If you want to use a more abstract language for
> > describing kernel 
> > security policies, fine.  Just don't use LISP.
> 
> Point me to ANy langage with VM around 100K.
> 
> > The right way to do it is this:
> > 
> > - A user space interpreter reads text-based config
> > files and converts 
> > them into a compact, easy-to-interpret code used by
> > the kernel.
> > 
> > - A VERY TINY kernel component is fed the security
> > policy and executes it.
> 
> it is exactly the way it is implemented. Not everyone
> need to create their own security model (that VERY
> TINY kernel component you refer to). But even for
> those who want to modify or create their own VERY TINY
> kernel component - they don't need to do that in C and
> debug it in th kernel crashing it.
> 
> > 
> > Move as much of the processing as reasonable into
> > user space.  It's 
> > absolutely unnecessary to have the parser into the
> > kernel, because 
> > parsing of the config files is done only when the
> > ASCII text version 
> > changes.
> > 
> > It's absolutely unnecessary to have something as
> > complex as LISP to 
> > interpret it, when something simple and compact
> > could do just as well.
> > 
> > Why do you choose LISP?  Don't you want to use a
> > language that sysadmins 
> > will actually KNOW?
> 
> It was is) the smallest VM I know of.
> 
> 99% of sysadmins don't need to create their own
> security models. Security polices are created with web
> interface very close to the way you described. So
> sysadmin don't need to know anything about LISP (to
> use predefined security models).
> 
> Serge.
> 
> 
> __________________________________
> Do you Yahoo!?
> Yahoo! Small Business $15K Web Design Giveaway 
> http://promotions.yahoo.com/design_giveaway/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
