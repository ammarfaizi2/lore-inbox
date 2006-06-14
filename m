Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWFNH6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWFNH6e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 03:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWFNH6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 03:58:33 -0400
Received: from relay03.pair.com ([209.68.5.17]:27662 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S1751230AbWFNH6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 03:58:32 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
Organization: Clientec, Inc.
To: bidulock@openss7.org
Subject: Re: [RFC/PATCH 1/2] in-kernel sockets API
Date: Wed, 14 Jun 2006 02:58:08 -0500
User-Agent: KMail/1.9.3
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1150156562.19929.32.camel@w-sridhar2.beaverton.ibm.com> <200606131953.42002.chase.venters@clientec.com> <20060614000710.C7232@openss7.org>
In-Reply-To: <20060614000710.C7232@openss7.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606140258.30302.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 June 2006 01:06, Brian F. G. Bidulock wrote:
>
> The interface currently under discussion is ultimately derived from the BSD
> socket-protocol interface, and IMHO should be EXPORT_SYMBOL instead of
> EXPORT_SYMBOL_GPL, if only because using _GPL serves no purpose here and
> can be defeated with 3 or 4 obvious (and probably existing) lines of code. 
> I wrote similar wrappers for STREAMS TPI to Linux NET4 interface instead of
> using pointers directly quite a few years ago.  I doubt I was the first.
> There is nothing really so novel here that it deserves _GPL.

I mentioned that I don't have any particular opinion on the BSD socket API in 
this discussion. All that I'm speaking of here is a property of licensing. 

I've watched a lot of what has happened with binary drivers. You'll find in 
the LKML archives plenty of lengthy discussions about whether or not binary 
drivers are allowed under the GPL. If I were to guess, there is still 
disagreement. Although some hardware support could improve, we thankfully 
seem to have some kind of an equilibrium capable of supporting lots of users.

One point I remember coming up in the discussion was that the 
EXPORT_SYMBOL()/EXPORT_SYMBOL_GPL() split was a compromise of sorts. 
Interfaces that were needed to support users would reasonably be placed under 
EXPORT_SYMBOL(). By contrast, EXPORT_SYMBOL_GPL() would indicate 
functionality that would only seem to be used by derived works. It implies 
that any code using it should probably be GPL as well.

I don't raise this in an attempt to belittle anything people are working on. 
It's an observation about the ecosystem - Linux in the 2.6 series has seen a 
great amount of corporate contribution in terms of enhancing what the kernel 
is capable of doing. GPL, I believe, encourages this.

Thanks,
Chase
