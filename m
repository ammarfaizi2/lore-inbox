Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318623AbSHBGeA>; Fri, 2 Aug 2002 02:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318626AbSHBGeA>; Fri, 2 Aug 2002 02:34:00 -0400
Received: from www.transvirtual.com ([206.14.214.140]:32523 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S318623AbSHBGd7>; Fri, 2 Aug 2002 02:33:59 -0400
Date: Thu, 1 Aug 2002 23:37:12 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Douglas Gilbert <dougg@torque.net>
cc: Banai Zoltan <bazooka@emitel.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.30
In-Reply-To: <3D49E238.64B48408@torque.net>
Message-ID: <Pine.LNX.4.44.0208012335000.29483-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Aug 01, 2002 at 08:12:34PM -0400, Alexander Viro wrote:
> > >
> > > Argh.  My fault - it's devfs-only code and it didn't get tested ;-/
> > >
> > > Fix: replace line 470 with
> > >               p[part].de = NULL;
> > >
> > Thanks, that help!
> >
> > But it does not boot,( nor does 2.5.24)
> > with 2.5.30 it panics at PNP BIOS initalisation,
> > without PNPBIOS it freezes after loop device init(no network card)
> > after network card init if configured (Intel e100).
> > No SysRq helps.:(
>
> Banai,
> Yep, the anti-devfs regime broke it a few versions ago
> with console/tty (serial) driver changes. It sort of defeats
> the purpose, but I can boot with "devfs=nomount" as a
> kernel boot up option. [This worked in lk 2.5.29]

I have nothing against devfs. In fact I spent the morning attempting to
get my machine to use devfs. I discovered that was harding than I thoyght
which is why I asked people to test my patch out. I think I'm going to
just send it into linus soon anyways.

