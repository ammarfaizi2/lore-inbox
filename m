Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317491AbSHBBeY>; Thu, 1 Aug 2002 21:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317521AbSHBBeY>; Thu, 1 Aug 2002 21:34:24 -0400
Received: from ns3.maptuit.com ([204.138.244.3]:34319 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S317491AbSHBBeX>;
	Thu, 1 Aug 2002 21:34:23 -0400
Message-ID: <3D49E238.64B48408@torque.net>
Date: Thu, 01 Aug 2002 21:36:56 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.29 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Banai Zoltan <bazooka@emitel.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.30
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Banai Zoltan <bazooka@emitel.hu> wrote:
On Thu, Aug 01, 2002 at 08:12:34PM -0400, Alexander Viro wrote:
> > 
> > Argh.  My fault - it's devfs-only code and it didn't get tested ;-/
> > 
> > Fix: replace line 470 with
> >               p[part].de = NULL;
> > 
> Thanks, that help!
> 
> But it does not boot,( nor does 2.5.24)
> with 2.5.30 it panics at PNP BIOS initalisation,
> without PNPBIOS it freezes after loop device init(no network card)
> after network card init if configured (Intel e100).
> No SysRq helps.:(

Banai,
Yep, the anti-devfs regime broke it a few versions ago
with console/tty (serial) driver changes. It sort of defeats
the purpose, but I can boot with "devfs=nomount" as a
kernel boot up option. [This worked in lk 2.5.29]

Resistance may be futile, but it is the reason some of
us use linux.

Doug Gilbert
