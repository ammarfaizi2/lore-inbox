Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752086AbWIXDs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086AbWIXDs7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 23:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752087AbWIXDs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 23:48:59 -0400
Received: from xenotime.net ([66.160.160.81]:10204 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1752086AbWIXDs7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 23:48:59 -0400
Date: Sat, 23 Sep 2006 20:50:08 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Aubrey <aubreylee@gmail.com>
Cc: "Arnd Bergmann" <arnd@arndb.de>, "Luke Yang" <luke.adi@gmail.com>,
       linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Message-Id: <20060923205008.618156a0.rdunlap@xenotime.net>
In-Reply-To: <6d6a94c50609232035x4025672dg4f02b3bcceb6d531@mail.gmail.com>
References: <489ecd0c0609202032l1c5540f7t980244e30d134ca0@mail.gmail.com>
	<200609230218.36894.arnd@arndb.de>
	<6d6a94c50609232035x4025672dg4f02b3bcceb6d531@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sep 2006 11:35:31 +0800 Aubrey wrote:

> On 9/23/06, Arnd Bergmann <arnd@arndb.de> wrote:
> > > +static uint32_t reloc_stack_operate(unsigned int oper, struct module *mod)
> > > +{
> > > +     uint32_t value;
> > > +     switch (oper) {
> > > +     case R_add:
> > > +             {
> > > +                     value =
> > > +                         reloc_stack[reloc_stack_tos - 2] +
> > > +                         reloc_stack[reloc_stack_tos - 1];
> > > +                     reloc_stack_tos -= 2;
> > > +                     break;
> > > +             }
> >
> > no need for the curly braces here and below
> 
> Hmm, but we need one line < 80 columns, don't we?

Yes (preferably), but:
The braces for case R_add above simply aren't needed at all.
And after they are removed, you can indent the remaining code
one less tab stop.

---
~Randy
