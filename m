Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319542AbSH3Kwl>; Fri, 30 Aug 2002 06:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319543AbSH3Kwl>; Fri, 30 Aug 2002 06:52:41 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:28398
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319542AbSH3Kwl>; Fri, 30 Aug 2002 06:52:41 -0400
Subject: Re: [PATCH] 6/41 sound/oss/pss.c - convert cli to spinlocks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: pwaechtler@mac.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020830074730.GF19611@louise.pinerecords.com>
References: <200208292154.g7TLs5ZH003520@smtp-relay02.mac.com> 
	<20020830074730.GF19611@louise.pinerecords.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 30 Aug 2002 11:56:58 +0100
Message-Id: <1030705018.3196.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-30 at 08:47, Tomas Szepe wrote:
> > static pss_confdata *devc = &pss_data;
>                            ^ ^
> > +static spinlock_t lock=SPIN_LOCK_UNLOCKED;
> 
> > 				if (!pss_put_dspword(devc, *data++)) {
>                                                           ^
> > +					spin_unlock_irqrestore(&lock,flags);
> 
> 
> Would you please take care not to clutter the original sources with
> lines in a different C formatting style?

When you've ported that much code to a new locking mechanism then you
can moan. If he wants to take on the old OSS code and making it work in
the 2.5 universe as far as I (as the ex OSS code maintainer) am concened
he can format it how he likes

