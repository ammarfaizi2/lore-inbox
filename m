Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964927AbVHOUjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbVHOUjl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 16:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbVHOUjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 16:39:40 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:27952 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964927AbVHOUjk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 16:39:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cZL1DuI2OtxRNLfrBN4OuoNf22MMV6TfIjoSqx03o6obWKyT0sf85tWHkecYeDqP4kmSt892kQ+4UzJtpAoTODztaSsqf5tuPf/0Pfny8R3s8iHkvB4Z380+5Q/nymW97cgJmJCaciM1TIqJrdcu5+2gQ7CVwvrB5BbddihQbLk=
Message-ID: <86802c440508151339790da3b2@mail.gmail.com>
Date: Mon, 15 Aug 2005 13:39:36 -0700
From: yhlu <yhlu.kernel@gmail.com>
To: James Simmons <jsimmons@infradead.org>
Subject: Re: Atyfb questions and issues
Cc: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>,
       Jim Ramsay <jim.ramsay@gmail.com>, alex.kern@gmx.de,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.56.0508151741510.7300@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.44.0508121918200.10526-100000@deadlock.et.tudelft.nl>
	 <Pine.LNX.4.56.0508121848040.30829@pentafluge.infradead.org>
	 <86802c4405081211153ec42f7e@mail.gmail.com>
	 <Pine.LNX.4.56.0508151741510.7300@pentafluge.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

last year some time, I have manually the patch from 2.4 to 2.6. my
patch result is the same as 2.4. It only works when bios doesn't do
the init. Then if the BIOS do the init, it will hang there. I assume
something only can be done once.

YH

On 8/15/05, James Simmons <jsimmons@infradead.org> wrote:
> 
> > james,
> >
> > I remember that xlinit in 2.6 kernel only works when BIOS option-rom
> > really init fb.
> > It can not work if the BIOS option rom is not executed.
> >
> > For 2.4, it reversed, it can not work if BIOS opton-rom is executed.
> > Only work if BIOS don't excute the option rom.
> 
> You are right. The init_from_bios is called on x86 in aty_setup_generic
> before aty_init which calls the biosless initialization. The question is
> what needs to be done to properly fix it?
> 
>
