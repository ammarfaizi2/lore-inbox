Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964965AbVJ0Ems@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbVJ0Ems (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 00:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbVJ0Ems
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 00:42:48 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:9992 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S964965AbVJ0Ems (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 00:42:48 -0400
Date: Thu, 27 Oct 2005 06:34:39 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: =?iso-8859-1?Q?Hans-J=FCrgen?= Mehnert <hjmehnert@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: kernel crashes 2.4.31final + 2.4.32rc1
Message-ID: <20051027043439.GL22601@alpha.home.local>
References: <8e9415f80510240824g5b7bca95h@mail.gmail.com> <20051026083956.GA9473@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051026083956.GA9473@logos.cnet>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans & Marcelo,

On Wed, Oct 26, 2005 at 06:39:56AM -0200, Marcelo Tosatti wrote:
> Hi Hans,
> 
> On Mon, Oct 24, 2005 at 05:24:14PM +0200, Hans-Jürgen Mehnert wrote:
> > [1.]
> > PROBLEM: kernel crashes 2.4.31final + 2.4.32rc1
> > 
> > 
> > [2.]
> > Since kernel version 2.4.31 we have system crashes with
> > blank screen and nothing in logs on at least 5 different
> > Intel and AMD SMP machines. 2.4.32rc1 has the same problem,
> > 2.4.30 is working stable on these machines. We had no crashes
> > with the newer kernel versions on about 100 single-cpu machines
> > so far.
> 
> Few questions:
> 
> - Can you send dmesg output?

you could also try to get messages on the screen by preventing from blanking
using setterm :

    # setterm -blank 0

Also, using a serial console to get and log messages can help.

> - Are you using the ahci driver with the Intel SATA controller? There have
> been some bugfixes in ahci during v2.4.31, although they dont look suspect.
> Is there load on the interface?
> 
> - Is the USB UHCI controller being used? There are known SMP problems 
> in the usb-uhci driver recently fixed (problem introduced in v2.4.28 though).
> 
> - What is the workload on these machines?
> 
> - Have you tried v2.4.31-pre1, -pre2, and so on to isolate the possibly problematic
> change?

I also saw that at least the machine shown in the report is using grsec. Are
all machines using grsec ? Although I don't believe it would be the cause,
we cannot exclude that a recent bug could have been introduced in it.

And what's the average time before a crash ? hours, days, weeks ?

Regards,
Willy

