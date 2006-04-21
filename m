Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbWDUQnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWDUQnu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 12:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWDUQnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 12:43:50 -0400
Received: from pproxy.gmail.com ([64.233.166.179]:47723 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751293AbWDUQnt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 12:43:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cpS7z0joeHx0RgNAE12xazRNIKqUDhVLCU8V2Hudqa+GV0JFvF3+nGvEY5497JXNlWMpQ9gxzGj80sh8uk6RfcgtyQS7eA4BybbIydoHFWu+pHOglkgzaGCoME0QHa3F7Kfu9NlgKvOBc7NjGf43B72sPomHyzAcyM4zj81URq0=
Message-ID: <bda6d13a0604210943jcf55e7cld564bad9b2b7b020@mail.gmail.com>
Date: Fri, 21 Apr 2006 09:43:48 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: NFS bug?
In-Reply-To: <1145628470.8150.10.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <b3be17f30604200937l7cfaca8evcc17f6ecd72f643e@mail.gmail.com>
	 <1145551304.8136.5.camel@lade.trondhjem.org>
	 <b3be17f30604200953i652e14a2n908f1a066ffe4e7f@mail.gmail.com>
	 <1145555789.8136.13.camel@lade.trondhjem.org>
	 <b3be17f30604201102jff51794r52dd3024d631051e@mail.gmail.com>
	 <1145556613.8136.14.camel@lade.trondhjem.org>
	 <b3be17f30604201114n7a50bad9u6f3839a029f571a7@mail.gmail.com>
	 <1145560845.8136.26.camel@lade.trondhjem.org>
	 <20060421005524.15f1c414.akpm@osdl.org>
	 <1145628470.8150.10.camel@lade.trondhjem.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >  Was there no stack trace in that Oops? AFAICS, getdents64() isn't
> > >  supposed to be calling __copy_from_user_ll() at all, so you appear to
> > >  have something very weird going here.
> >
> > I'd be guessing that filldir64() was passed a negative namlen.
>
> Why would that trigger a bug in __copy_from_user_ll()? I could see it
> triggering errors in copy_to_user(), but not copy_from_*...
>
> Cheers,
>   Trond

I've made that mistake before. Passing copy_from_user a negative
length -> crash.
