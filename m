Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285352AbSBDSe6>; Mon, 4 Feb 2002 13:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285023AbSBDSes>; Mon, 4 Feb 2002 13:34:48 -0500
Received: from dsl-65-186-161-49.telocity.com ([65.186.161.49]:16648 "EHLO
	nic.osagesoftware.com") by vger.kernel.org with ESMTP
	id <S282845AbSBDSee>; Mon, 4 Feb 2002 13:34:34 -0500
Message-Id: <4.3.2.7.2.20020204133252.00c50f00@mail.osagesoftware.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 04 Feb 2002 13:34:40 -0500
To: lkml <linux-kernel@vger.kernel.org>
From: David Relson <relson@osagesoftware.com>
Subject: Re: How to check the kernel compile options ?
In-Reply-To: <a3mjhc$qba$1@cesium.transmeta.com>
In-Reply-To: <3C5EB070.4370181B@uni-mb.si>
 <3C5EB070.4370181B@uni-mb.si>
 <4.3.2.7.2.20020204124812.00aec590@mail.osagesoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:22 PM 2/4/02, you wrote:
>Followup to:  <4.3.2.7.2.20020204124812.00aec590@mail.osagesoftware.com>
>By author:    David Relson <relson@osagesoftware.com>
>In newsgroup: linux.dev.kernel
> >
> > I remember discussion of that patch some time ago and the main complaint
> > about it was that it increases the size of the kernel, i.e. vmlinuz.  Why
> > not put the need info in a module?  Doing that would enable the following
> > command:
> >
> >          zgrep CONFIG_PROC /lib/modules/`uname -r`/config.gz
> >
> > (or something similar).
> >
>
>Uhm, no.  The problem with it is that you're using kernel memory
>because you're not willing to manage userspace competently, so modules
>(in fact, *using modules at all*) would be right out.

Yeah, it does have the undesirable dependency on modules, doesn't it?


>I have had in my /sbin/installkernel a clause to save .config as
>config-<foo> when I install vmlinuz-<foo>; I believe anyone not doing
>that[1] is, quite frankly, a moron.

Why not a simple patch for "make install" to do this?

