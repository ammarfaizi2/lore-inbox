Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318085AbSHKSqU>; Sun, 11 Aug 2002 14:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318099AbSHKSqU>; Sun, 11 Aug 2002 14:46:20 -0400
Received: from codepoet.org ([166.70.99.138]:61922 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S318085AbSHKSqT>;
	Sun, 11 Aug 2002 14:46:19 -0400
Date: Sun, 11 Aug 2002 12:49:56 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre1
Message-ID: <20020811184956.GA25592@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0208051938380.6811-100000@freak.distro.conectiva> <20020811085717.GA17738@codepoet.org> <1029095179.16236.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1029095179.16236.16.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Aug 11, 2002 at 08:46:19PM +0100, Alan Cox wrote:
> On Sun, 2002-08-11 at 09:57, Erik Andersen wrote:
> > On Mon Aug 05, 2002 at 07:40:56PM -0300, Marcelo Tosatti wrote:
> > > 
> > > So here goes -pre1, with a big -ac and x86-64 merges, plus other smaller
> > > stuff.
> > [------------snip------------]
> > > <alan@irongate.swansea.linux.org.uk> (02/08/05 1.629)
> > > 	[PATCH] PATCH: Add EFI partition support
> > 
> > Needs this to compile....
> > 
> > --- linux/include/asm-ia64/efi.h.orig	Sun Aug 11 01:41:10 2002
> > +++ linux/include/asm-ia64/efi.h	Sun Aug 11 01:43:38 2002
> > @@ -166,6 +166,9 @@
> >   *  EFI Configuration Table and GUID definitions
> >   */
> >  
> > +#define NULL_GUID    \
> > +    ((efi_guid_t) { 0x00000000, 0x0000, 0x0000, { 0x00, 0x00, 0x0, 0x00, 0x00, 0x00, 0x00, 0x00 }})
> > +
> 
> Not a good plan. EFI can be used on non ia64 so NULL_GUID belongs
> somewhere else


I know.  But if you look at the source, the generic stuff is
directly including asm-ia64/efi.h, so this makes it compile.  I
agree having the generic stuff include asm-ia64 code is really
stupid, but changing that seemed far more invasive and frankly, I
don't even know what an "EFI" is, so I didn't want to mess with
it beyond making it compile per how it is currently doing things,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
