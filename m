Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267185AbTBQQzy>; Mon, 17 Feb 2003 11:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267208AbTBQQy7>; Mon, 17 Feb 2003 11:54:59 -0500
Received: from air-2.osdl.org ([65.172.181.6]:34432 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S267191AbTBQQy3>;
	Mon, 17 Feb 2003 11:54:29 -0500
Date: Mon, 17 Feb 2003 09:03:39 -0800
From: Bob Miller <rem@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Lars Magne Ingebrigtsen <larsi@gnus.org>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.60 5/9] Update the Archimedes parallel port driver for new module API.
Message-ID: <20030217170339.GA23052@doc.pdx.osdl.net>
References: <20030215100424.A20365@flint.arm.linux.org.uk> <20030217030304.60DFA2C30D@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030217030304.60DFA2C30D@lists.samba.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2003 at 01:54:59PM +1100, Rusty Russell wrote:
> In message <20030215100424.A20365@flint.arm.linux.org.uk> you write:
> > On Fri, Feb 14, 2003 at 04:37:00PM -0800, Bob Miller wrote:
> > > -static void arc_inc_use_count(void)
> > > +static int arc_inc_use_count(void)
> > >  {
> > > -#ifdef MODULE
> > > -	MOD_INC_USE_COUNT;
> > > -#endif
> > > +	return try_module_get(THIS_MODULE);
> > >  }
> > 
> > Isn't one of the points of the module system that we don't try to run
> > code inside a module without the module being reference counted?
> 
> Exactly.  You can do it if you *know* you already hold a reference
> count, but as a general rule it's damn suspicious.
> 
> This looks wrong,
> Rusty.

Thanks for the feed back.  I'll fix this and re-submit.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
