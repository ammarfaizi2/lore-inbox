Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265143AbRGBQmg>; Mon, 2 Jul 2001 12:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265335AbRGBQmQ>; Mon, 2 Jul 2001 12:42:16 -0400
Received: from t2.redhat.com ([199.183.24.243]:28403 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S265143AbRGBQmM>; Mon, 2 Jul 2001 12:42:12 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <E15H6R1-00066U-00@the-village.bc.nu> 
In-Reply-To: <E15H6R1-00066U-00@the-village.bc.nu> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dhowells@redhat.com (David Howells), jes@sunsite.dk (Jes Sorensen),
        linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: [RFC] I/O Access Abstractions 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 02 Jul 2001 17:41:36 +0100
Message-ID: <19921.994092096@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
>  The question I think being ignored here is. Why not leave things as
> is.

Because if we just pass in this one extra piece of information which is
normally already available in the driver, we can avoid a whole lot of ugly
cruft in the out-of-line functions by plugging in the correct out-of-line 
function to match the resource. 

> The multiple bus stuff is a port specific detail hidden behind
> readb() and friends. 

The alternative view is that the _single_ bus stuff is a port-specific
detail which has permeated all the drivers and forced the non-i386
architectures' I/O functions to have to try to work out which bus they're
talking to when the driver could have just passed that information to them.

--
dwmw2


