Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270212AbTHLKE6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 06:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270214AbTHLKE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 06:04:58 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:15564 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S270212AbTHLKE4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 06:04:56 -0400
Date: Tue, 12 Aug 2003 12:03:21 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
cc: Greg KH <greg@kroah.com>, Matthew Wilcox <willy@debian.org>,
       Robert Love <rml@tech9.net>, CaT <cat@zip.com.au>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
In-Reply-To: <Pine.LNX.4.51.0308121100200.17669@dns.toxicfilms.tv>
Message-ID: <Pine.GSO.4.21.0308121202470.20533-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Aug 2003, Maciej Soltysiak wrote:
> > > static struct pci_device_id tg3_pci_tbl[] __devinitdata = {
> > > 	{
> > > 		.vendor		= PCI_VENDOR_ID_BROADCOM,
> > > 		.device		= PCI_DEVICE_ID_TIGON3_5700,
> > > 		.subvendor	= PCI_ANY_ID,
> > > 		.subdevice	= PCI_ANY_ID,
> > > 		.class		= 0,
> > > 		.class_mask	= 0,
> > > 		.driver_data	= 0,
> > > 	},
> >
> > I sure would.  Oh, you can drop the .class, .class_mask, and
> > .driver_data lines, and then it even looks cleaner.
> Just a quick question. if we drop these, will they _always_
> be initialised 0 ? I have made a test to see, and it seemed as though,
> but I would like to be 100% sure.

For globals and static locals: yes.
For non-static locals: no.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

