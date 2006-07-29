Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422650AbWG2Gnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422650AbWG2Gnx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 02:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422648AbWG2Gnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 02:43:53 -0400
Received: from web36707.mail.mud.yahoo.com ([209.191.85.41]:30353 "HELO
	web36707.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422650AbWG2Gnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 02:43:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=axPJWoQCQ/sLHyC9/fiYWbe/ol9oCfg3d+hQlnnuwNUT2/tmqYmNgYcOV1Ocm7MwimJRNxdoiImjQRJkTTvi/gkGIjmyFLRlCfFvmYZSOOur6EFNe2xgZmbGB+6RVkvUdsTp2l1y0G/FooRTBCwhFxIUOQc3NF9JrbCQxDUE3fY=  ;
Message-ID: <20060729064351.80412.qmail@web36707.mail.mud.yahoo.com>
Date: Fri, 28 Jul 2006 23:43:51 -0700 (PDT)
From: Alex Dubov <oakad@yahoo.com>
Subject: Re: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash card readers
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-kernel@vger.kernel.org, pazke@donpac.ru
In-Reply-To: <200607281604.k6SG4xV3021888@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No optimization. I just thought both 0xffffffff and -1
are ugly.

--- Mikael Pettersson <mikpe@it.uu.se> wrote:

> On Fri, 28 Jul 2006 06:02:11 -0700 (PDT), Alex Dubov
> wrote:
> >The exact condition is (irq_status!=0 &&
> >irq_status!=0xffffffff). I think it is not any
> better
> >that what I have.
> >
> >--- Andrey Panin <pazke@donpac.ru> wrote:
> >
> >> On 208, 07 27, 2006 at 08:34:06PM -0700, Alex
> Dubov
> >> wrote:
> >> 
> >> What this strange line (in tifm_7xx1_isr
> function)
> >> is supposed to do:
> >> 
> >>         if(irq_status && (~irq_status))
> 
> If you're chasing micro-optimisations, you could
> write
> 
>     /* if irq_status is not 0 or ~0, do <blah> */
>     if (((unsigned)irq_status + 1) >= 2)
> 
> which should reduce the number of conditional
> branches
> to a single one. (And drop the cast if irq_status is
> declared as unsigned.)
> 
> But for long-term maintenance just spelling out the
> exact
> condition (irq_status != 0 && irq_status != ~0) is
> preferable.
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
