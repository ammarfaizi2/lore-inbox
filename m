Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbVLYS4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbVLYS4A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 13:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbVLYS4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 13:56:00 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:14664 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750889AbVLYSz7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 13:55:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NGWyjVeNsPjFbh6oG5ic4FvxqYApWtuf8Ca0MQ8OMONdgwnBh/VAygpdfz1EvIKKBDyU/hjjsDNjCYoabvFhGqSmiZ8hvyH+pjBeRVxilU84gt5awC8HIrd3aEnQ5me3MowYSHWWNQ6XhO5F3e1akojrvxG4IQvKrZ7F8cGdiDM=
Message-ID: <1e62d1370512251055t69ce0c5g97e95a05e727852b@mail.gmail.com>
Date: Sun, 25 Dec 2005 23:55:58 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
To: Mateusz Berezecki <mateuszb@gmail.com>
Subject: Re: kernel list / container_of aka list_entry question
Cc: Michael Buesch <mbuesch@freenet.de>, kernel-mentors@selenic.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <aec8d6fc0512251028v1338cc2cn2d8d58e4685c178@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <aec8d6fc0512250850m4f8d4bd6y3772638d620548cd@mail.gmail.com>
	 <1e62d1370512250924r4e3078d0ubb8986d52ac8aeb@mail.gmail.com>
	 <200512251910.49869.mbuesch@freenet.de>
	 <aec8d6fc0512251028v1338cc2cn2d8d58e4685c178@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/25/05, Mateusz Berezecki <mateuszb@gmail.com> wrote:
> On 12/25/05, Michael Buesch <mbuesch@freenet.de> wrote:
>
> > > >         list_for_each(iterator, &priv->rxbuf.list) {
> > > >                 struct ath_buf *bf = list_entry(iterator, (struct ath_buf), list);
> >                                                               ^              ^
> > Remove the parenthesis.
>
> yikes. that helped. but it's somewhat weird IMHO... why ((struct foo)
> *) wont work?
> and it needs to be (struct foo *) ?
>

What I can say is that compiler will consider the construct like
(struct foo *)  as this (struct foo)* will be making compiler confused
that (struct foo) is type-casting and the * might be for deferencing
the pointer but as * is also in a bracket and wont follow any pointer
thats why compiler is giving error. (CMIIW)

--
Fawad Lateef
