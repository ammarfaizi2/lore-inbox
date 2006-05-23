Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbWEWRVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWEWRVa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 13:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbWEWRV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 13:21:29 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:62924 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751002AbWEWRV3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 13:21:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CSfle811oMqUiLZTBn8+YHfv7EGyYSJuFLISyVG3/DKmHrDxfpYXYoWQNhn5Repee2KyjIS2U/r0YpWtiYmK7c59DTNyYa4js9l3J0NlwR+KK/fxOtz849xN2qogpGG5tx0B0MIzlNVAg2p2zAreNid+vhkNHvBO7rN03yDYlgE=
Message-ID: <9b5164430605231021h589dd194g8d88d46d1fcc4209@mail.gmail.com>
Date: Tue, 23 May 2006 10:21:28 -0700
From: "Xiong Jiang" <linuster@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
In-Reply-To: <9b5164430605231015s40ebcd38had1c3029da8afc7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <44700ACC.8070207@gmail.com>
	 <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com>
	 <1148379089.25255.9.camel@localhost.localdomain>
	 <4472E3D8.9030403@garzik.org>
	 <83B4C39B-1A5E-4734-A5FF-10C3179B535B@mac.com>
	 <1148395433.25255.66.camel@localhost.localdomain>
	 <ADF9B4F7-2B6E-41B7-8B83-26261EBE27F7@mac.com>
	 <1148403226.25255.89.camel@localhost.localdomain>
	 <9b5164430605231015s40ebcd38had1c3029da8afc7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------- Forwarded message ----------
From: Xiong Jiang <linuster@gmail.com>
Date: May 23, 2006 10:15 AM
Subject: Re: OpenGL-based framebuffer concepts
To: Alan Cox <alan@lxorguk.ukuu.org.uk>


What about initialization, mode and context switching? From the
discussion I thought that people would like to see X server and
framebuffer console could coexist in a more coordinated way, which
could be coordinated DRI in kernel.

Agreed that kernel should only deal with necessary tasks as minimum as
possible. 2D/3D engine in user mode and the reorg of Xserver/APIs
around the engine is the thing people are discussing.

Designing the interface inevitably involves clear understanding of the
hardware capabilities and closed hardware spec is an obvious obstacle.
Open Graphics card (when becoming available) would be a great thing
and I wish a great X run it to its full strength.

It's a little offtopic for this list but, it's an interface between
kernel and user mode so both the Xorg and this mailing list would see
a lot discussion on it. I am glad to see such discussion is happening.

Of course a lot of education is needed for me to discuss such, with
the wish that a better X / GUI running on modern graphics hardware is
desirable for everyone.

Regards,

On 5/23/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Maw, 2006-05-23 at 11:41 -0400, Kyle Moffett wrote:
> > So a modern GPU is essentially a proprietary CPU with an obscure
> > instruction set and lots of specialized texel hardware?  Given the
> > total lack of documentation from either ATI or NVidia about such
> > cards I'd guess it's impossible for Linux to provide any kind of
> > reasonable 3d engine for that kind of environment, and it might be
> > better to target a design like the Open Graphics Project is working
> > to provide.
>
> Its typically a device you feed a series of fairly low level rendering
> commands to sometimes including instructions (eg shaders). DRI provides
> an interface that is chip dependant but typically looks like
>
>
>      [User provided command buffer]
>                    |
>      [Kernel filtering/DMA interface]
>                    |
>      [Card command queue processing]
>
>
> All the higher level graphic work is done in the 3D client itself.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
