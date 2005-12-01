Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbVLALMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbVLALMb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 06:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbVLALMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 06:12:31 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:21170 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932149AbVLALMa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 06:12:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Hkky6sCfyt8KtD3b2PxH5MDgQWQJuh3Eto7KRoPg/RfiO81Z5fxvuFSSNP4h7bhbiyBPowidcePH+8zilfPOy+yactXfvqF1Ozk+veoCC7N+Hsr5nA/0zidRZsR69WJwkA94x1koToULYwfYNUa+Z4BJRhZZlQuJ/K6F7M9zClk=
Message-ID: <58cb370e0512010311s77a57305w5e9c7294ec09900a@mail.gmail.com>
Date: Thu, 1 Dec 2005 12:11:24 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, dwmw2@infradead.org,
       vagabon.xyz@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [NET] Remove ARM dependency for dm9000 driver
In-Reply-To: <20051201105227.GA19317@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051130190224.GE1053@flint.arm.linux.org.uk>
	 <1133426199.4117.179.camel@baythorne.infradead.org>
	 <20051201094111.GA14726@flint.arm.linux.org.uk>
	 <20051201.015115.49187117.davem@davemloft.net>
	 <20051201105227.GA19317@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> On Thu, Dec 01, 2005 at 01:51:15AM -0800, David S. Miller wrote:
> > From: Russell King <rmk+lkml@arm.linux.org.uk>
> > Date: Thu, 1 Dec 2005 09:41:11 +0000
> >
> > > In which case why do we restrict floppy to only those machines which
> > > could have floppy?  Why do we restrict IDE to only those platforms
> > > which may have IDE?
> >
> > These two examples require platform level support via
> > an asm/*.h header file.
> >
> > Whereas the driver's we are talking about use portable
> > interfaces that should be available across the board.
> >
> > So, bad example.
>
> Not in the IDE case.  Bart restricted IDE to a smaller number of ARM
> platforms, plus any that had PCMCIA.  There is no such restriction
> in the asm-arm/*.h header files.

When I did this change there was such restriction in asm-arm/mach-*/ide.h
files (some platforms just lacked ide.h making IDE build break for them).

IDE is a bad example anyway because of legacy ordering issues etc etc.

> if PCMCIA || ARCH_CLPS7500 || ARCH_IOP3XX || ARCH_IXP4XX \
>         || ARCH_L7200 || ARCH_LH7A40X || ARCH_PXA || ARCH_RPC \
>         || ARCH_S3C2410 || ARCH_SA1100 || ARCH_SHARK || FOOTBRIDGE
> source "drivers/ide/Kconfig"
> endif
