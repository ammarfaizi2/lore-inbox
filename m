Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263162AbTC1VlS>; Fri, 28 Mar 2003 16:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263163AbTC1VlR>; Fri, 28 Mar 2003 16:41:17 -0500
Received: from tomts16.bellnexxia.net ([209.226.175.4]:17654 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S263162AbTC1VlQ>; Fri, 28 Mar 2003 16:41:16 -0500
Date: Fri, 28 Mar 2003 16:47:24 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: more details on laptop keyboard problems, 2.5.66-bk4
In-Reply-To: <20030328134006.4311dbf3.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.44.0303281645420.1190-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Mar 2003, Randy.Dunlap wrote:

> On Fri, 28 Mar 2003 16:26:53 -0500 (EST) "Robert P. J. Day" <rpjday@mindspring.com> wrote:
> 
> |   ok, here's a little more info.  as i was booting my dell
> | laptop with 2.5.66-bk4, just after the "Starting sendmail"
> | message, i got a screenful of
> | 
> |   atkbd.c: Unknown key (set 0, scancode 0x0, on isa0060/serio1) pressed.
> | 
> | i did in fact build support for an AT keyboard (CONFIG_KEYBOARD_ATKBD)
> | directly into the kernel, since it seemed based on the explanation
> | that i needed that.  (to refresh your memory, i have both the built-in
> | keyboard and a PS/2 keyboard which is plugged into the combo 
> | keyboard/mouse port on the back, and under 2.4.18, both are
> | functional at the same time.)
> | 
> ...
> | 
> |   but one step at a time -- any suggestions regarding that "atkbd.c"
> | error??  i'm assuming that i really need that option selected, no?
> 
> Any chance that you need to set CONFIG_I8K ?
> 
> config I8K
> 	tristate "Dell laptop support"
> 	---help---
> 	  This adds a driver to safely access the System Management Mode
> 	  of the CPU on the Dell Inspiron 8000. The System Management Mode
> 	  is used to read cpu temperature and cooling fan status and to
> 	  control the fans on the I8K portables.

that's already selected as a module, as it was with my 2.4.18 kernel.
but it's unlikely that's the cause -- all that feature is for is to
support i8kutils, which allows one to do things like read cpu temp
and so on.  that feature is definitely optional, and shouldn't make
any difference, but it's already in there as a module anyway.

rday

