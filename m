Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263802AbTFPL7Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 07:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263786AbTFPL7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 07:59:16 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:44693 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263802AbTFPL7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 07:59:13 -0400
Date: Mon, 16 Jun 2003 14:12:45 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ian Molton <spyro@f2s.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: FRAMEBUFFER policy
In-Reply-To: <20030616020012.3f2d27dd.spyro@f2s.com>
Message-ID: <Pine.GSO.4.21.0306161411410.15789-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jun 2003, Ian Molton wrote:
> What is the policy as regards linux framebuffer drivers when presented
> with a mode they cannot handle.
> 
> eg, suppose a driver can only handle even numbers of pixels and a
> request is made for a mode with 639 pixels - should it allocate a 640
> pixel wide mode?
> 
> or should it extend the height of a mode to allow hardware scrolling in
> multiples of the font height?

If you pass a mode that cannot be handled, the driver must try to round up some
values to make it work. If that's not possible, an error is returned.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

