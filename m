Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261459AbRFJShB>; Sun, 10 Jun 2001 14:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261493AbRFJSgw>; Sun, 10 Jun 2001 14:36:52 -0400
Received: from hood.tvd.be ([195.162.196.21]:11429 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S261459AbRFJSgg>;
	Sun, 10 Jun 2001 14:36:36 -0400
Date: Sun, 10 Jun 2001 20:34:01 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Nico Schottelius <nicos@pcsystems.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: scsi disk defect or kernel driver defect ?
In-Reply-To: <3B1FD67D.8DFDAE58@pcsystems.de>
Message-ID: <Pine.LNX.4.05.10106102029390.24376-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jun 2001, Nico Schottelius wrote:
> Or does anybody have a hp c1536 streamer and can help me ?

The manual for my C1536A says:

| The C1536A does not support termination on the device itself. Normally, the
| unit will not be placed at the end of a bus. However, if this is
| unavoidable, we recommend the use of an additional length of cable with a
| terminator attached. (Lack of space does not allow for a feed-through
| connector to be used to the drive.)

| Terminator: Methode Active SCSI Terminator DM1050-02-R
|             Methode Passive SCSI Terminator DM1050-02-0

So you should get a terminator (or an addtional SCSI device that does have a
termination dipswitch/jumper, like my CD-ROM drive :-)

This also explains why it works without the C1536: in that case your SCSI host
adapter will auto-terminate the empty narrow chain.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



