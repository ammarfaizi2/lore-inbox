Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263208AbUKUJXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263208AbUKUJXM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 04:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbUKUJXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 04:23:12 -0500
Received: from witte.sonytel.be ([80.88.33.193]:47076 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262940AbUKUJXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 04:23:06 -0500
Date: Sun, 21 Nov 2004 10:22:33 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Alan Cox <alan@redhat.com>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>,
       Marcelo Tosatti <marcelo@hera.kernel.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: linux-2.4.28 released
In-Reply-To: <419E0644.909@pobox.com>
Message-ID: <Pine.GSO.4.61.0411211021550.19680@waterleaf.sonytel.be>
References: <BF571719A4041A478005EF3F08EA6DF05EB481@pcsmail03.pcs.pc.ome.toshiba.co.jp>
 <20041118111235.GA26216@logos.cnet> <20041119134832.GA9552@havoc.gtf.org>
 <20041119135452.GA10422@devserv.devel.redhat.com> <419E0644.909@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Nov 2004, Jeff Garzik wrote:
> Alan Cox wrote:
> > On Fri, Nov 19, 2004 at 08:48:32AM -0500, Jeff Garzik wrote:
> > > PATA and SATA (DMA doesn't work for PATA, in split-driver configuration),
> > > and there is no split-driver to worry about.
> > > 
> > > I think there may need to be some code to prevent the IDE driver from
> > > claiming the legacy ISA ports.
> > 
> > Its called "request_resource". If you want the resource claim it. IDE will
> > be a good citizen.
> 
> That's what the quirk does.  libata still needs to find out who obtained the
> resource, not blindly grab it (and fail).

If libata would be initialized before IDE, it could grab the resource during
probing.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
