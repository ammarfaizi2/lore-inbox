Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276759AbRJaAO0>; Tue, 30 Oct 2001 19:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275990AbRJaAOR>; Tue, 30 Oct 2001 19:14:17 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50449 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S276759AbRJaAOL>; Tue, 30 Oct 2001 19:14:11 -0500
Date: Tue, 30 Oct 2001 16:12:36 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Denis Zaitsev <zzz@cd-club.ru>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] init/main.c/root_dev_names - another one #ifdef
In-Reply-To: <E15yj2E-0001o7-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0110301610460.1336-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 31 Oct 2001, Alan Cox wrote:
>
> It took that out deliberately a few months back. The ifdefs in fact
> break stuff
>
> Firstly the array is __init so is discarded on boot

I think that array really is broken. We should get the name association
from the array that "register_blkdev()" maintains, I'm sure. That way
random stupid driver X doesn't need to touch a common init/main.c file,
which I find personally offensive.

		Linus

