Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752117AbWIXE2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117AbWIXE2z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 00:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752118AbWIXE2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 00:28:55 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:14773 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1752117AbWIXE2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 00:28:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jUFJvEPiY85sCJ2A4zRtuYV2JowZ7x2/SLU923WNNDhQpEwM22j6A/Y/zUyhIWpN0SHsEphypGnvQptBWGTD82Vv97cFG++sHBxTem8tfVXCmuw7mmxW34GCqO3y3d4tOIp0vodoEBr5HJQI5NnovwyOFw5zqLxD+kSc8Pn78Nc=
Message-ID: <6d6a94c50609232128o52d1f92br58f598587f4e1f06@mail.gmail.com>
Date: Sun, 24 Sep 2006 12:28:53 +0800
From: Aubrey <aubreylee@gmail.com>
To: "Randy Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Cc: "Arnd Bergmann" <arnd@arndb.de>, "Luke Yang" <luke.adi@gmail.com>,
       linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <20060923205008.618156a0.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <489ecd0c0609202032l1c5540f7t980244e30d134ca0@mail.gmail.com>
	 <200609230218.36894.arnd@arndb.de>
	 <6d6a94c50609232035x4025672dg4f02b3bcceb6d531@mail.gmail.com>
	 <20060923205008.618156a0.rdunlap@xenotime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/06, Randy Dunlap <rdunlap@xenotime.net> wrote:
> On Sun, 24 Sep 2006 11:35:31 +0800 Aubrey wrote:
>
> > On 9/23/06, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > +static uint32_t reloc_stack_operate(unsigned int oper, struct module *mod)
> > > > +{
> > > > +     uint32_t value;
> > > > +     switch (oper) {
> > > > +     case R_add:
> > > > +             {
> > > > +                     value =
> > > > +                         reloc_stack[reloc_stack_tos - 2] +
> > > > +                         reloc_stack[reloc_stack_tos - 1];
> > > > +                     reloc_stack_tos -= 2;
> > > > +                     break;
> > > > +             }
> > >
> > > no need for the curly braces here and below
> >
> > Hmm, but we need one line < 80 columns, don't we?
>
> Yes (preferably), but:
> The braces for case R_add above simply aren't needed at all.
> And after they are removed, you can indent the remaining code
> one less tab stop.
>
Yeah, the braces for case should be removed. Done.
