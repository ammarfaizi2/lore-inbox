Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135788AbREBTfE>; Wed, 2 May 2001 15:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135782AbREBTez>; Wed, 2 May 2001 15:34:55 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:13572 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135786AbREBTer>; Wed, 2 May 2001 15:34:47 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
Date: 2 May 2001 12:34:11 -0700
Organization: A poorly-installed InterNetNews site
Message-ID: <9cpnfj$ms3$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0104290914260.14261-100000@twinlark.arctic.org> <200104292116.f3TLGhu07016@pachyderm.pa.dec.com> <20010502211800.X805@mea-ext.zmailer.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010502211800.X805@mea-ext.zmailer.org>,
Matti Aarnio  <matti.aarnio@zmailer.org> wrote:
>On Sun, Apr 29, 2001 at 02:16:43PM -0700, Jim Gettys wrote:
>...
>> "X is an exercise in avoiding system calls".  I think I said this around
>> 1984-1985.  
>> 				- Jim
>
>I think that applies to all really high-performance servers.

Note that it is definitely not always true.

Linux system calls are reasonably light-weight.  And sometimes trying to
avoid them ends up beaing _more_ work - because you might have to worry
about synchronization and cache coherency in user mode. 

So the rule should be "avoid _unnecessary_ system calls".

		Linus
