Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268899AbRHPV7Z>; Thu, 16 Aug 2001 17:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268901AbRHPV7P>; Thu, 16 Aug 2001 17:59:15 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:19352 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S268899AbRHPV67>; Thu, 16 Aug 2001 17:58:59 -0400
Date: Thu, 16 Aug 2001 17:59:13 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200108162159.f7GLxDN30681@devserv.devel.redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Apps losing control tty...
In-Reply-To: <mailman.997952524.13885.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.997952524.13885.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> prerequisities: 2.4.7-vanille
>      Recently (i cant recall when), i realised, that
> some _different_ applications (like mikmod or something)
>  are losing tty. I start these apps like that:
> mikmod <random stuff skipped> > /dev/ttyXX 2>/dev/ttyXX < /dev/ttyXX &
> and after some period of time, they loses the
> tty, but this is not a 100% probability.
> 
>  I think it is relevant only for 2.4.7 in my situation...
> 
> ---
>    Samium Gromoff

Samium did not elaborate what he means under "loses the tty",
but perhaps I can report something related.

Sometimes (not very often), after I do "ssh somehost",
the resulting bash runs without a some controlling terminal
function. Running "cat" from that shell (on somehost)
yields a cat that cannot be interrupted with a signal
from keyboard. ^D works. "stty -a" shows isig set.
tty shows PTY slave correctly.

This is related to 2.4.7 and SMP, I think.

-- Pete
