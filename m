Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751429AbWCBU2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbWCBU2R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 15:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbWCBU2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 15:28:17 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:26412 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751429AbWCBU2Q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 15:28:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZW6VkQ6/EztLJnAvJIsOViMSrLH67V4YXncW9cewtbLiTRJQkv6vCsCC5Iby9ovVTj6T17xIAyQN5vZGABA2/JNonhqTWoie1CMyTgviUY7+gCyhyaX7ihXGJr/cDGrNwMYEORVbMGM/00gKA1jgbF5YefGkKwsleb0/NZGSEf8=
Message-ID: <9a8748490603021228k7ad1fb5gd931d9778307ca58@mail.gmail.com>
Date: Thu, 2 Mar 2006 21:28:15 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: [2.6 patch] make UNIX a bool
Cc: "Herbert Xu" <herbert@gondor.apana.org.au>, dtor_core@ameritech.net,
       jgeorgas@rogers.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060302173840.GB9295@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060301175852.GA4708@stusta.de>
	 <E1FEcfG-000486-00@gondolin.me.apana.org.au>
	 <20060302173840.GB9295@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/06, Adrian Bunk <bunk@stusta.de> wrote:
> On Thu, Mar 02, 2006 at 12:31:34PM +1100, Herbert Xu wrote:
> > Adrian Bunk <bunk@stusta.de> wrote:
> > >
> > > It does also matter in the kernel image size case, since you have to put
> > > enough modules to the other medium for having a effect bigger than the
> > > kernel image size increase from setting CONFIG_MODULES=y.
> >
> > That's not very difficult considering the large number of modules that's
> > out there that a system may wish to use.
> >...
>
> This might be true for full-blown desktop systems - but these do not
> tend to be the systems where kernel image size matters that much.
> Smaller kernel image size might be an issue e.g. for distribution
> kernels, but in a much less pressing way.
>
> The systems where kernel image size really matters are systems with few
> modules where you know in advance which modules you might need. I played
> a bit with the ARM defconfigs, and if you consider that you can't build
> the filesystem for accessing your modules modular I haven't found any
> where making everything modular would have given a real kernel image
> size gain compared to the CONFIG_MODULES=n case.
>

I believe the basic question is this: What do we win by making
CONFIG_UNIX a bool?

As it is now eople have the option of building it in, building a
module or not build it at all - I don't see why that's a bad thing.
For people who want a small core kernel (for whatever reason) and then
load additional capabilities as modules, the current situation is
good. If we remove the modular option who will bennefit?
Why not just leave it as it is?

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
