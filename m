Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270022AbUJHPqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270022AbUJHPqQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 11:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270040AbUJHPoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 11:44:02 -0400
Received: from colin2.muc.de ([193.149.48.15]:13833 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S270022AbUJHPm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 11:42:28 -0400
Date: 8 Oct 2004 17:42:27 +0200
Date: Fri, 8 Oct 2004 17:42:27 +0200
From: Andi Kleen <ak@muc.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make gcc -align options .config-settable
Message-ID: <20041008154227.GA91816@muc.de>
References: <2KBq9-2S1-15@gated-at.bofh.it> <m3pt3t9zaj.fsf@averell.firstfloor.org> <200410081710.58766.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410081710.58766.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2004 at 05:10:58PM +0000, Denis Vlasenko wrote:
> On Friday 08 October 2004 12:20, Andi Kleen wrote:
> > Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> writes:
> > > Resend.
> > >
> > > With all alignment options set to 1 (minimum alignment),
> > > I've got 5% smaller vmlinux compared to one built with
> > > default code alignment.
> > >
> > > Rediffed against 2.6.9-rc3.
> > > Please apply.
> >
> > I agree with the basic idea (the big alignments also always annoy
> > me when I look at disassembly), but I think your CONFIG options
> > are far too complicated. I don't think anybody will go as far as
> > to tune loops vs function calls.
> >
> > I would just do a single CONFIG_NO_ALIGNMENTS that sets everything to
> > 1, that should be enough.
> 
> For me, yes, but there are people which are slightly less obsessed
> with code size than me.
> 
> They might want to say "try to align to 16 bytes if
> it costs less than 5 bytes" etc.

If they want to go down to that low level they can as well edit
the Makefiles. But we already have far too many configs and
adding new ones for obscure compiler options is not a good idea.

Also we don't normally add stuff "just in case", but only when
people actually use it.

-Andi

