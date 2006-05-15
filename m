Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964943AbWEOTlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbWEOTlm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 15:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbWEOTlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 15:41:42 -0400
Received: from ns.suse.de ([195.135.220.2]:35536 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964943AbWEOTll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 15:41:41 -0400
From: Andi Kleen <ak@suse.de>
To: Marko Macek <Marko.Macek@gmx.net>
Subject: Re: ASUS A8V Deluxe, x86_64
Date: Mon, 15 May 2006 21:41:36 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <8E8F647D7835334B985D069AE964A4F7028FDBFE@ECQCMTLMAIL1.quebec.int.ec.gc.ca> <p738xp35co4.fsf@bragg.suse.de> <4468D53F.9090507@gmx.net>
In-Reply-To: <4468D53F.9090507@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605152141.36452.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 May 2006 21:23, Marko Macek wrote:
> Andi Kleen wrote:
> > "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA> writes:
> > 
> >>> I also have A8V Deluxe.
> >>>
> >>> No real problems with single core A64 3000.
> >>>
> >>> But now with and X2 dual core CPU, I needed to disable 
> >>> irqbalance to get any stability.
> >> Hein? Via xconfig?
> > 
> > I cant't see the parent message (did you mess up the cc?) of the
> > person with irqbalanced troubles, but most likely he has a SIS chipset, right? 
> 
> No, VIA A8V Deluxe.
> 
> See for example:
> 
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=182618

Ok, that's new. We knew that SIS didn't like setting interrupt
affinity on IRQ 0. Maybe VIA forgot to validate one of these cases too.

On SUSE it was workarounded in irqbalanced user space but since other 
distributions seem to be lazy to pick that fix up we should probably
do a kernel side fix. I'll put it on my todo list.

-Andi

