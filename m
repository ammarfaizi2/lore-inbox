Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286395AbRLJVcU>; Mon, 10 Dec 2001 16:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284704AbRLJVcL>; Mon, 10 Dec 2001 16:32:11 -0500
Received: from hera.cwi.nl ([192.16.191.8]:11968 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S286395AbRLJVb7>;
	Mon, 10 Dec 2001 16:31:59 -0500
From: Andries.Brouwer@cwi.nl
Date: Mon, 10 Dec 2001 21:31:23 GMT
Message-Id: <UTC200112102131.VAA281019.aeb@cwi.nl>
To: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk
Subject: Re: Linux/Pro  -- clusters
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Alan Cox <alan@lxorguk.ukuu.org.uk>

    >     And it means we can get proper refcounting. Which as the maintainer
    >     of two block drivers that support dynamic volume create/destroy is
    >     remarkably good news.
    > 
    > You say this as if that would be a difference between the two
    > approaches. I don't think it is.

    Its easier to make sure its correct when we have a single structure not
    a pile of arrays.

I don't understand your reference to arrays. Nobody uses arrays.
That is something of the past.

    Object lifetime becomes explicit, and we don't have to
    worry about re-use races since a new instance of that major,minor
    will have a different object attached to the one in use that is
    about to be refcounted into oblivion by currently active requests

As described, my setup certainly has no re-use races, since
I do not use refcounts as a way to terminate the lifespan of
a kdev_t. So, are you saying that you prefer my version?
I have problems reading your replies.

Andries
