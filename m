Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313988AbSD2RrJ>; Mon, 29 Apr 2002 13:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314050AbSD2RrI>; Mon, 29 Apr 2002 13:47:08 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:55527 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S313988AbSD2RrH>; Mon, 29 Apr 2002 13:47:07 -0400
Date: Mon, 29 Apr 2002 13:46:59 -0400
From: Arjan van de Ven <arjanv@redhat.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, Dave Hansen <haveblue@us.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: devfs: BKL *not* taken while opening devices
Message-ID: <20020429134659.A26165@devserv.devel.redhat.com>
In-Reply-To: <3CCD811E.8689F4B0@redhat.com> <Pine.LNX.4.21.0204291937430.23113-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Apr 29, 2002 at 07:40:08PM +0200, Roman Zippel wrote:
> Hi,
> 
> On Mon, 29 Apr 2002, Arjan van de Ven wrote:
> 
> > I'm not convinced of that. It's not nearly a critical path and it's
> > better to get even the "dumb" drivers safe than to risk having big
> > security holes in there for years to come.
> 
> The BKL doesn't make a driver safe, remember that it's released on
> schedule.

I know. But a LOT of in kernel and out-of kernel drives don't schedule
in open and are therefore safe right now

