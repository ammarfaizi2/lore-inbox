Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130831AbRCFBv7>; Mon, 5 Mar 2001 20:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130832AbRCFBvt>; Mon, 5 Mar 2001 20:51:49 -0500
Received: from [199.183.24.200] ([199.183.24.200]:23340 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S130831AbRCFBvp>; Mon, 5 Mar 2001 20:51:45 -0500
Date: Mon, 5 Mar 2001 20:51:39 -0500
From: Peter Zaitcev <zaitcev@redhat.com>
To: Alan Cox <alan@redhat.com>
Cc: Peter Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch to ymfpci from ALSA 0.99
Message-ID: <20010305205139.A26463@devserv.devel.redhat.com>
In-Reply-To: <20010305192524.A19811@devserv.devel.redhat.com> <200103060146.f261kWY26310@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200103060146.f261kWY26310@devserv.devel.redhat.com>; from alan@redhat.com on Mon, Mar 05, 2001 at 08:46:32PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Alan Cox <alan@redhat.com>
> To: zaitcev@redhat.com (Peter Zaitcev)
> Date: Mon, 5 Mar 2001 20:46:32 -0500 (EST)

> > -static unsigned long int	DspInst[] = {
> > +static unsigned long DspInst[YDSXG_DSPLENGTH / 4] = {
> >  	0x00000081, 0x000001a4, 0x0000000a, 0x0000002f,
> >  	0x00080253, 0x01800317, 0x0000407b, 0x0000843f,
> 
> This seems wrong (actually I suspect its a continuation of wrongness. What
> about 64bit platforms - u32 maybe ?)

It will work on 64 bits, only use 2 times more memory for the storage.
Should be safe to change to int or u32.

-- Pete
