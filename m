Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422763AbWA1Aya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422763AbWA1Aya (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 19:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422764AbWA1Aya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 19:54:30 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:12984 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422763AbWA1Aya convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 19:54:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N7sU80iixxjpwTn7QY5yhdC58jZNVw5kXMNKx/dYSXG6TG+drRRccMCiqREUMFeGbmPslN0LGlBcbhJGpD1m2XiVBTCwIsJsybuFe0eQSuQ6jENjq3Merq4UMwaUmiLXhsylWL3Xuf1ubuBmZnbaenK9J07+hN49hHvxu8Hm0BM=
Message-ID: <cfb54190601271654i8a001b7y5c37b27e2e7fa0ed@mail.gmail.com>
Date: Sat, 28 Jan 2006 02:54:29 +0200
From: Hai Zaar <haizaar@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: vesa fb is slow on 2.6.15.1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43DABCF6.4000904@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <cfb54190601260620l5848ba3ai9d7e06c41d98c362@mail.gmail.com>
	 <43D8E1EE.3040302@gmail.com>
	 <cfb54190601260806h7199d7aej79139140d145d592@mail.gmail.com>
	 <43D94764.3040303@gmail.com>
	 <cfb54190601261610o1479b8fdsbedb0ca96b14b6@mail.gmail.com>
	 <43D9B77E.6080003@gmail.com>
	 <cfb54190601270832x29681873i624818603d5db26e@mail.gmail.com>
	 <43DA5681.2020305@gmail.com>
	 <cfb54190601271628j774df3d0xce0ab24c8abca845@mail.gmail.com>
	 <43DABCF6.4000904@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> Hai Zaar wrote:
> >> Looks harmless to me.
> >>
> >> Can you check /proc/iomem just to verify if that particular address has
> >> been reserved by the OS.
> > Relevant iomem entries are:
> > f0000000-f7ffffff : PCI Bus #40
> >   f0000000-f7ffffff : 0000:40:00.0
> >     f0000000-f7ffffff : vesafb
> > f8000000-f9ffffff : PCI Bus #40
> >   f8000000-f8ffffff : 0000:40:00.0
> >   f9000000-f9ffffff : 0000:40:00.0
> > After I load nvidia.ko, it changes to:
> > f0000000-f7ffffff : PCI Bus #40
> >   f0000000-f7ffffff : 0000:40:00.0
> >     f0000000-f7ffffff : vesafb
> > f8000000-f9ffffff : PCI Bus #40
> >   f8000000-f8ffffff : 0000:40:00.0
>     ^^^^^^^^
> Yes, this address range (16M) is already allocated to resource #0
> of the nvidia card.  So trying to allocate resource #6 on the same
> address looks bogus to me.

Ok. What now?
I've rebooted without 'vga' and 'video' parameters at all - the error stays.

BTW: How do you know that its allocated to resource #0 - are resource
numbers written somewhere in /proc/iomem and I've missed it?


> Tony
>


--
Zaar
