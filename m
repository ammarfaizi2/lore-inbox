Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269645AbRHAFDA>; Wed, 1 Aug 2001 01:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269519AbRHAFCt>; Wed, 1 Aug 2001 01:02:49 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:45584 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269645AbRHAFCe>; Wed, 1 Aug 2001 01:02:34 -0400
Date: Wed, 1 Aug 2001 00:32:55 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrew Tridgell <tridge@valinux.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8preX VM problems
In-Reply-To: <20010801043749.3AE4C44A4@lists.samba.org>
Message-ID: <Pine.LNX.4.21.0108010023050.8866-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Tue, 31 Jul 2001, Andrew Tridgell wrote:

> Marcelo wrote:
> > Can you reproduce the problem with 2.4.7 ? 
> 
> no, it started with 2.4.8pre1. I am currently narrowing it down by
> reverting pieces of that patch and I have successfully narrowed it
> down to the changes in mm/vmscan.c. I have a 2.4.8pre3 kernel with a
> hacked version of the 2.4.7 vmscan.c that doesn't show the
> problem. 

Could you please apply
http://bazar.conectiva.com.br/~marcelo/patches/v2.4/2.4.7pre9/zoned.patch
on top of 2.4.7 and try to reproduce the problem ? 

> I'll try to narrow it down a bit more this afternoon.

There are two possibilities: 

1) the zoned approach code introduced in 2.4.8pre1 (thats why I asked you
to apply the patch alone on top of 2.4.7).

2) The used-once code also introduced in 2.4.8pre1

It seems the problem only happens when the highmem zone is active, right ?


