Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbVHXRbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbVHXRbq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 13:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbVHXRbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 13:31:46 -0400
Received: from web25809.mail.ukl.yahoo.com ([217.12.10.194]:20318 "HELO
	web25809.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751326AbVHXRbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 13:31:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=F94Ym8AutwB/IcyohjfrEbvG6dZG1OrsAvxoxFZIwo3j0/3eqp43RhYSXd2SpqnkUnSVMKMgy2ybK0aPgmivNlTjB1EvuuZBZIlLhjO16vdNRKnpVgqBcYduijyJ7ep8I7+61eSCGKEC8ScvUScg/HS0393nZqQJdfoJiapaMCU=  ;
Message-ID: <20050824173131.50938.qmail@web25809.mail.ukl.yahoo.com>
Date: Wed, 24 Aug 2005 19:31:31 +0200 (CEST)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: question on memory barrier
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0508240854550.28064@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- "linux-os (Dick Johnson)" <linux-os@analogic.com> a écrit :

> 
> On Wed, 24 Aug 2005, moreau francis wrote:
> 
> > Hi,
> >
> > I'm currently trying to write a USB driver for Linux. The device must be
> > configured by writing some values into the same register but I want to be
> > sure that the writing order is respected by either the compiler and the
> cpu.
> >
> > For example, here is a bit of driver's code:
> >
> > """
> > #include <asm/io.h>
> >
> > static inline void dev_out(u32 *reg, u32 value)
> > {
> >        writel(value, regs);
> > }
> >
> > void config_dev(void)
> > {
> >        dev_out(reg_a, 0x0); /* first io */
> >        dev_out(reg_a, 0xA); /* second io */
> > }
> >
> 
> This should be fine. The effect of the first bit of code
> plus all side-effects (if any) should be complete at the
> first effective sequence-point (;) but you need to

sorry but I'm not sure to understand you...Do you mean that the first write
into reg_a pointer will be completed before the second write because they're
separated by a (;) ?
Or because writes are encapsulated inside an inline function, therefore
compiler
must execute every single writes before returning from the inline function ?

Thanks.

            Francis


	

	
		
___________________________________________________________________________ 
Appel audio GRATUIT partout dans le monde avec le nouveau Yahoo! Messenger 
Téléchargez cette version sur http://fr.messenger.yahoo.com
