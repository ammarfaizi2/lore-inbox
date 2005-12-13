Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbVLMUtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbVLMUtQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 15:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030197AbVLMUtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 15:49:16 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:24377 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030196AbVLMUtQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 15:49:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iUByHvLuXwi+/5hDC0qqkQe/4WJGyVna0M5pi5yD5ljef1yubixeLuOF8ok72hHwvmLxhowjy5SyyZ4wXhluY2oZVQDHNu3n0Nwel3BBLJ2cjRJ/nzLjXZi6lo+whINFGRINvyP6eSjRP3lBBE51mwYTJDtC3NtwjaHkVqpFPJ4=
Message-ID: <d120d5000512131248j79a93d5ex8667ca6a38452a1d@mail.gmail.com>
Date: Tue, 13 Dec 2005 15:48:47 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Stelian Pop <stelian@popies.net>
Subject: Re: sonypi searching new maintainer (Was: Re: [RFT] Sonypi: convert to the new platform device interface)
Cc: Mattia Dongili <malattia@linux.it>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1134505855.9642.28.camel@deep-space-9.dsnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <200512130219.41034.dtor_core@ameritech.net>
	 <20051213183248.GA3606@inferi.kami.home>
	 <d120d5000512131104x260fdbf2mcc58fb953559fec5@mail.gmail.com>
	 <1134505855.9642.28.camel@deep-space-9.dsnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/05, Stelian Pop <stelian@popies.net> wrote:
> Le mardi 13 décembre 2005 à 14:04 -0500, Dmitry Torokhov a >
> > > sonypi: unknown event port1=0x0f,port2=0x05
> [...]
> > > Oh, there seems to be a spurious interrupt happening at modules
> > > insertion (I suspect sonypi_enable triggering and ignoring it), but this
> > > happens with the old module too and I never noticed it before. Wouldn't
> > > make more sense to print the warning even if verbose=0 to be able to
> > > catch it timely? I mean it's since 2.4 times I don't enable verbose mode
> > > in sonypi...
> > >
> > Probably, let's see what Stelian will say.
>
> This is the "ok I'm loaded" event. I am not sure this event is available
> on all the sonypi supported platforms, that's why it hasn't been defined
> as a known event. And it doesn't make much sense to forward it anyways.
>
> I would leave it like it is now.
>

But when it is reported is it the same event? If so we could just not
warn when we see it (but still dont forward it to the userspace).

--
Dmitry
