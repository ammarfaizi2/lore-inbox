Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265725AbSKFPuH>; Wed, 6 Nov 2002 10:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265732AbSKFPuH>; Wed, 6 Nov 2002 10:50:07 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:64152 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265725AbSKFPuG>; Wed, 6 Nov 2002 10:50:06 -0500
Subject: Re: Voyager subarchitecture for 2.5.46
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0211060729210.2393-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0211060729210.2393-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Nov 2002 16:19:09 +0000
Message-Id: <1036599549.9803.49.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-06 at 15:45, Linus Torvalds wrote:
> It's clearly stupid in the long run to depend on the TSC synchronization.
> We should consider different CPU's to be different clock-domains, and just
> synchronize them using the primitives we already have (hey, people can use
> ntp to synchronize over networks quite well, and that's without the kind
> of synchronization primitives that we have within the same box).

NTP synchronization assumes the clock runs at approximately the same
speed and that you can 'bend' ticklength to avoid backward steps. Thats
a really cool idea for the x440 but I wonder how practical it is when we
have CPU's that keep changing speeds and not always notifying us about
it either.


