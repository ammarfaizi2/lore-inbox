Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265022AbTFLVvF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 17:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265023AbTFLVvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 17:51:04 -0400
Received: from imf.math.ku.dk ([130.225.103.32]:5793 "EHLO imf.math.ku.dk")
	by vger.kernel.org with ESMTP id S265022AbTFLVvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 17:51:01 -0400
Date: Fri, 13 Jun 2003 00:01:35 +0200 (CEST)
From: Peter Berg Larsen <pebl@math.ku.dk>
To: Peter Osterlund <petero2@telia.com>
Cc: CaT <cat@zip.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
In-Reply-To: <m27k7rnmwm.fsf@telia.com>
Message-ID: <Pine.LNX.4.40.0306122321010.10788-100000@shannon.math.ku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > On Wed, Jun 11, 2003 at 10:48:14PM -0400, Joseph Fannin wrote:
> > > > Here is a new patch that sends ABS_ events to user space. I haven't
> > > > modified the XFree86 driver to handle this format yet, but I used
> > > > /dev/input/event* to verify that the driver generates correct data.

> > CaT <cat@zip.com.au> writes:
> > Aaaand... will I be able to transparently use my ps2 mouse and touchpad
> > without having to worry about what's plugged in at any one time?

The short answer is no, if you still have the gateway laptop.


On 12 Jun 2003, Peter Osterlund wrote:
> It works on my computer at least. When loading the psmouse module I
> get this:

>         input: PS/2 Logitech Mouse on isa0060/serio2
>         input: Synaptics Synaptics TouchPad on isa0060/serio4

It works for you because it (your laptop) has active multiplexing. Without
active multiplexing I see no way of demultiplexing different mouse
protocols in mousedev.

A guestdevice behind the touchpad also needs demultiplexing even with
activ multiplexing. This could be done in the synaptics driver but as the
guestdevice can be any device, the synaptics driver needs to know every
mouse protocol there is to demultiplex it. The synaptics driver sent does
not demultiplex a guestdevice.


Peter


