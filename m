Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265716AbSJSXHk>; Sat, 19 Oct 2002 19:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265719AbSJSXHk>; Sat, 19 Oct 2002 19:07:40 -0400
Received: from ns1.system-techniques.com ([199.33.245.254]:49112 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S265716AbSJSXHX>; Sat, 19 Oct 2002 19:07:23 -0400
Date: Sat, 19 Oct 2002 19:12:21 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: davidsen <root@tmr.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: NCR adaptor doesn't see devices (was: 2.5.43 aic7xxx segfault)
In-Reply-To: <Pine.LNX.4.44.0210190913380.1364-200000@bilbo.tmr.com>
Message-ID: <Pine.LNX.4.44.0210191910050.7796-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44.0210191910061.7796@filesrv1.baby-dragons.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Davidsen ,  I hope the Sym-2 driver is what you are using ?
	From the dmesg output I suspect that is not the case .  If there
	is only the one Symbios/LSI driver I hope it is the Sym-2
	version .  Hth ,  JimL

On Sat, 19 Oct 2002, davidsen wrote:
> On Wed, 16 Oct 2002, Patrick Mansfield wrote:
> > On Wed, Oct 16, 2002 at 12:41:14PM -0700, Adam Radford wrote:
> > > I think sd_synchronize_cache() is getting called after SHT->release()
> > > function,
> > > which couldn't possibly be right.  This causes adaptec, 3ware, etc, to
> > > segfault
> > > on rmmod.
> > > See below for adaptec segfault output:
>         [ let's not ]
> > Are you sure it is not a BUG? This looks just like what Badari reported
> > yesterday:
>         [ more BUG output snipped ]
> > I posted a patch to change the put_device() calls to device_unregister(),
> > st.c got fixed in 2.5.43, these are still not fixed in 2.5.43:
>
> I got the same type of thing in 2.5.43, 43-mm2. Applied the patch below
> and the BUG went away. Unfortunately the NCR still doesn't see the
> attached devices, normally a CD and tape drive. I pulled the tape drive to
> see if that helps, it didn't. All works just fine with 2.4.recent. dmesg
> output attached to preserve format.
--
       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

