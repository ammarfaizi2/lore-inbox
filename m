Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130307AbRCBEVo>; Thu, 1 Mar 2001 23:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130308AbRCBEVf>; Thu, 1 Mar 2001 23:21:35 -0500
Received: from tomts8.bellnexxia.net ([209.226.175.52]:10416 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S130307AbRCBEVX>; Thu, 1 Mar 2001 23:21:23 -0500
Message-ID: <3A9F1EAB.7530DF5C@coplanar.net>
Date: Thu, 01 Mar 2001 23:16:43 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Rogerio Brito <rbrito@iname.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Newbie] Re: Problem creating filesystem
In-Reply-To: <11dd01c0a04e$98b92e60$f40237d1@MIACFERNANDEZ> <3A9B24BE.69777690@coplanar.net> <20010301225739.A674@iname.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogerio Brito wrote:

> On Feb 26 2001, Jeremy Jackson wrote:
> > Carlos Fernandez Sanz wrote:
> > > The IDE controller is
> > >   Bus  0, device  17, function  0:
> > >     Unknown mass storage controller: Promise Technology Unknown device (rev
> > > 2).
> > >       Vendor id=105a. Device id=d30.
> > >       Medium devsel.  IRQ 10.  Master Capable.  Latency=32.
> >
> > Unrelated to disk "problem", you might want to set your PCI latency timer in
> > BIOS to 64 or more.

This should be accessible in your BIOS setup.  I'm basing my comments on
one NIC driver complaining in my logs and overriding settings lower that 64;
however the general idea is to trade off latency for throughput.  If I go crazy,
like 192 or so, on *my* system, sound card starts to pop a bit, indicating that
it's fifo buffer is smaller that that and is emptying when other devices
are using the bus at the same time (it's like a timeslice)

>
>
>         Ok, I understand that this is probably off-topic and way too
>         basic, but what exactly would this do, in layman terms? Would
>         the latency being set to 32 result in any potential data
>         corruption?  BTW, to set this quantity, one should use setpci,
>         right?

