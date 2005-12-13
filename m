Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030256AbVLMWG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbVLMWG4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbVLMWGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:06:55 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:5922 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030256AbVLMWGz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:06:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Hu4jbGpMRnTgCPg1Hm4iJvgkQsDFdNwgxOiIJfHcrLcPlNZB+KeOQrlDX+olOZUjlQ89qogpBXkUy9vHLSKXWXOwZeEFlkBWu5kP8+q/J9Agaf3hFF9d+SQi8hZTmIQqjRTVf37EMj/l1SCpk61NedUbk51sLSqJvolGvlCy9aY=
Message-ID: <d120d5000512131406t2cff3c19ic309c5cb766b8d01@mail.gmail.com>
Date: Tue, 13 Dec 2005 17:06:53 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Stelian Pop <stelian@popies.net>
Subject: Re: sonypi searching new maintainer (Was: Re: [RFT] Sonypi: convert to the new platform device interface)
Cc: Mattia Dongili <malattia@linux.it>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1134510936.9642.31.camel@deep-space-9.dsnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <200512130219.41034.dtor_core@ameritech.net>
	 <20051213183248.GA3606@inferi.kami.home>
	 <d120d5000512131104x260fdbf2mcc58fb953559fec5@mail.gmail.com>
	 <1134505855.9642.28.camel@deep-space-9.dsnet>
	 <d120d5000512131248j79a93d5ex8667ca6a38452a1d@mail.gmail.com>
	 <1134510936.9642.31.camel@deep-space-9.dsnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/05, Stelian Pop <stelian@popies.net> wrote:
> Le mardi 13 décembre 2005 à 15:48 -0500, Dmitry Torokhov a écrit :
> > On 12/13/05, Stelian Pop <stelian@popies.net> wrote:
> > > Le mardi 13 décembre 2005 à 14:04 -0500, Dmitry Torokhov a >
> > > > > sonypi: unknown event port1=0x0f,port2=0x05
> > > [...]
> > > > > Oh, there seems to be a spurious interrupt happening at modules
> > > > > insertion (I suspect sonypi_enable triggering and ignoring it), but this
> > > > > happens with the old module too and I never noticed it before. Wouldn't
> > > > > make more sense to print the warning even if verbose=0 to be able to
> > > > > catch it timely? I mean it's since 2.4 times I don't enable verbose mode
> > > > > in sonypi...
> > > > >
> > > > Probably, let's see what Stelian will say.
> > >
> > > This is the "ok I'm loaded" event. I am not sure this event is available
> > > on all the sonypi supported platforms, that's why it hasn't been defined
> > > as a known event. And it doesn't make much sense to forward it anyways.
> > >
> > > I would leave it like it is now.
> > >
> >
> > But when it is reported is it the same event?
>
> I don't follow you here...
>

I was talking about that "ok, i'm loaded" event. When it is reported
is it the same v1,v2 pair all the time? If it is the same we could
suppress "unknown" message in verbose mode.

--
Dmitry
