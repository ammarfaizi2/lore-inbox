Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129308AbQKKVz6>; Sat, 11 Nov 2000 16:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129145AbQKKVzs>; Sat, 11 Nov 2000 16:55:48 -0500
Received: from cx425802-a.blvue1.ne.home.com ([24.0.54.216]:19972 "EHLO
	wr5z.localdomain") by vger.kernel.org with ESMTP id <S129136AbQKKVzi>;
	Sat, 11 Nov 2000 16:55:38 -0500
Date: Sat, 11 Nov 2000 15:55:23 -0600 (CST)
From: Thomas Molina <tmolina@home.com>
To: Stephen Thomas <stephen.thomas@insignia.com>
cc: Mark Hindley <mh15@st-andrews.ac.uk>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: opl3 under 2.4.0-test10
In-Reply-To: <3A0DAD50.8C55A494@insignia.com>
Message-ID: <Pine.LNX.4.21.0011111550130.953-100000@wr5z.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Nov 2000, Stephen Thomas wrote:

> Mark Hindley wrote:
> > I am trying to setup my ALS 110 soundcard under my build of kernel
> > 2.4.0-test10.
> > 
> > I have built in isapnp support and also the sb and opl3 drivers.
> > 
> > However, even though I pass opl3=0x388 on the Kernel command line all
> > I get is an isapnp panic.
> 
> CONFIG_SOUND_YM3812=y
> 
> and I'm passing "opl3=0x388" to the driver.  However, if I query
> what synth devices the driver supports, it only reports an
> AWE32-0.4.4 (RAM512k) sample device.  I expect it report an FM synth
> device, too.  I get the same (lack of) effect if I go via the
> adlib_card code, by saying "adlib=0x388".  My investigations so
> far have shown that when opl3_detect() first tries to get the
> signature of the OPL3 device, it gets 0xff from the inb() (line
> 195 of drivers/sound/opl3.c in test11pre1), while the corresponding
> code in 2.2.18pre19 gets 0x00.

Can you try resetting CONFIG_SOUND_YM3812 to m rather than y.  I had a
similar problem and that is the workaround I came up with.  I haven't
gone back and tried to see why it happened; maybe I need to.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
