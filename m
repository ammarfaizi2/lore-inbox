Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317016AbSEWVh0>; Thu, 23 May 2002 17:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317017AbSEWVhZ>; Thu, 23 May 2002 17:37:25 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:20474 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S317016AbSEWVhX>; Thu, 23 May 2002 17:37:23 -0400
Date: Thu, 23 May 2002 17:37:16 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Christer Weinigel <wingel@acolyte.hack.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.17 /dev/ports
Message-ID: <20020523173716.B12899@devserv.devel.redhat.com>
In-Reply-To: <Pine.LNX.4.33.0205231251430.2815-100000@penguin.transmeta.com> <3CED438B.6090906@evision-ventures.com> <20020523212239.EA736F5B@acolyte.hack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Christer Weinigel <wingel@acolyte.hack.org>
> Date: Thu, 23 May 2002 23:22:39 +0200 (CEST)

> Martin Dalecki <dalecki@evision-ventures.com> wrote:
> 
> > "I will submitt my dual 8255 PIO ISA card driver from 1.xx days
> > immediately for kernel inclusion"
> 
> Please do *grin* I will probably have to write a driver for just such
> a card (a PC104 card though, but that's just a differenct connector),
> so I'd love to have such a driver. [...]

The 8255 is way too flexible for a single driver to be possible,
IMHO. Also, it is used in devices which plug into a variety of
upstream APIs, which makes the factorization not worth the effort.
E.g. what if you have 8255 driving a 9 track tape and 8255 driving
HP-IB bus? I think it would hardly be reasonable to unify those.
OTOH, If Martin submits a header file with register breakdown,
it may be useful (unlike a continuation of /dev/port discussion).

-- Pete
