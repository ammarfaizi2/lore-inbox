Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbVILHYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbVILHYG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 03:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbVILHYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 03:24:06 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:31181 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1751196AbVILHYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 03:24:05 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: x86-fix-cmpxchg.patch added to -mm tree
Date: Mon, 12 Sep 2005 10:23:20 +0300
User-Agent: KMail/1.8.2
Cc: akpm@osdl.org, "Dave Jones" <davej@redhat.com>, zwane@holomorphy.com,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       zach@vmware.com
References: <200509100006.j8A06rZm020089@shell0.pdx.osdl.net> <20050910003038.GH5283@redhat.com> <43253F2E0200007800024DD4@sinclair.provo.novell.com>
In-Reply-To: <43253F2E0200007800024DD4@sinclair.provo.novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509121023.20520.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 September 2005 09:41, Jan Beulich wrote:
> >>> Dave Jones <davej@redhat.com> 10.09.05 02:30:38 >>>
> >On Fri, Sep 09, 2005 at 05:06:56PM -0700, Andrew Morton wrote:
> >
> > > - cmpxchg8b gets disabled when the minimum specified hardware
> architectur
> > >   doesn't support it (like was already happening for the byte,
> word, and
> > >   long ones).
> > >
> > > +config X86_CMPXCHG64
> > > +	bool
> > > +	depends on !M386 && !M486 && !MCYRIXIII && !MGEODEGX1
> > > +	default y
> >
> >This is wrong.  All the Winchip/CyrixIII CPUs do indeed have cx8.
> >Though cpuid will report that it's missing until We explicitly enable
> >it in init_c3().  Whilst it's "disabled" however, the instruction does
> >run perfectly fine.   This was done because Win NT wouldn't boot if it
> >found a non Intel CPU which had cx8 iirc.

Can this be added to comments in the right place?

> >I'm not familiar with the Geode enough to answer definitively.
> >Alan seems to be the Geode-guru, and may still have datasheets for
> that.
> 
> Resubmitting adjusted patch (taking into account also Alan's later
> response).
--
vda
