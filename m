Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282967AbRK0WCs>; Tue, 27 Nov 2001 17:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282973AbRK0WCj>; Tue, 27 Nov 2001 17:02:39 -0500
Received: from c0mailgw.prontomail.com ([216.163.180.10]:47820 "EHLO
	c0mailgw08.prontomail.com") by vger.kernel.org with ESMTP
	id <S282967AbRK0WCd>; Tue, 27 Nov 2001 17:02:33 -0500
Message-ID: <3C040D66.BB8BAD19@starband.net>
Date: Tue, 27 Nov 2001 17:02:14 -0500
From: war <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulus@samba.org
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.16 Bug (PPC)
In-Reply-To: <3C028378.50CA616C@starband.net> <15364.1721.506563.253393@gargle.gargle.HOWL>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Already learned how to fix this earlier, had to have nvram compiled in.


Paul Mackerras wrote:

> war writes:
>
> > Bug still resides in 2.4.16 still, even after the PPC fixes that were
> > applied to 2.4.16-pre1.
> >
> > If nobody cares about PPC updates, I guess I should put the box back on
> > the shelf.
>
> Gratuitous rudeness will usually get you an answer. :)
>
> > The video driver (plat) is the framebuffer for a few macs, without it,
> > I cannot do anything.
> >
> > Any plans to fix this?
> >
> > //              default_vmode = nvram_read_byte(NV_VMODE);
> > //              default_cmode = nvram_read_byte(NV_CMODE);
> >
> > Commenting the two undefined functions out in drivers/video/platinumfb.c
> > allows for a successful compile.
> > It also allows for the video driver to be brought up succesfully.
>
> Have you reported this before, on this list or anywhere else?
>
> The problem is that your config is slightly unusual in that you have
> turned off CONFIG_NVRAM.  We can put some ifdefs in so that it
> compiles without CONFIG_NVRAM.  For now, just turn on CONFIG_NVRAM.
>
> Paul.

