Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316158AbSGHGjB>; Mon, 8 Jul 2002 02:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316390AbSGHGjA>; Mon, 8 Jul 2002 02:39:00 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:9618 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316158AbSGHGjA> convert rfc822-to-8bit; Mon, 8 Jul 2002 02:39:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Subject: Re: [OKS] Module removal
Date: Mon, 8 Jul 2002 08:42:14 +0200
User-Agent: KMail/1.4.1
Cc: Werner Almesberger <wa@almesberger.net>, Bill Davidsen <davidsen@tmr.com>,
       Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
References: <20020702133658.I2295@almesberger.net> <200207072341.22896.oliver@neukum.name> <20020708013141.A13387@kushida.apsleyroad.org>
In-Reply-To: <20020708013141.A13387@kushida.apsleyroad.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207080842.14281.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Catching the entry points is what the current `try_inc_mod_count' code
> does.  I can't think of another way to do that.

The old way "2.2-rules" are safe on UP without preempt. So if you
temporarily, through the freeze hack, can introduce these conditions,
you've solved it. Except that you need to deal with a failure due to
an elevated usage count.

IMHO you gain very little by finding partial solutions which won't
help you in the hard cases. Module unload is very rare. It just needs
to work. You need to optimise use of modules, not the unload.
Strictly speaking, by having owner fields you punish drivers compiled
statically. The effect is small and not worth doing something about
it, but it should show the direction.

	Regards
		Oliver

