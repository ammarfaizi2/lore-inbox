Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277103AbRJDSfs>; Thu, 4 Oct 2001 14:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276942AbRJDSfi>; Thu, 4 Oct 2001 14:35:38 -0400
Received: from shell.cyberus.ca ([209.195.95.7]:41914 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S277103AbRJDSf2>;
	Thu, 4 Oct 2001 14:35:28 -0400
Date: Thu, 4 Oct 2001 14:33:00 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, <netdev@oss.sgi.com>,
        Simon Kirby <sim@netnation.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <20011004114021.F31061@turbolinux.com>
Message-ID: <Pine.GSO.4.30.0110041423140.10825-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Oct 2001, Andreas Dilger wrote:

> On Oct 04, 2001  07:34 -0400, jamal wrote:
> > 1) you shut down shared interupts; take a look at this posting by Marcus
> > Sundberg <marcus@cendio.se>
> >
> > ---------------
> >
> >   0:    7602983          XT-PIC  timer
> >   1:      10575          XT-PIC  keyboard
> >   2:          0          XT-PIC  cascade
> >   8:          1          XT-PIC  rtc
> >  11:    1626004          XT-PIC  Toshiba America Info Systems ToPIC95 PCI
> > \
> > to Cardbus Bridge with ZV Support, Toshiba America Info Systems ToPIC95
> > PCI \
> > to Cardbus Bridge with ZV Support (#2), usb-uhci, eth0, BreezeCom Card, \
> > Intel 440MX, irda0  12:       1342          XT-PIC  PS/2 Mouse
> >  14:      23605          XT-PIC  ide0
> >
> > -----------------------------
> >
> > Now you go and shut down IRQ 11 and punish all devices there. If you can
> > avoid that, it is acceptable as a temporary replacement to be upgraded to
> > a better scheme.
>
> Well, if we fall back to polling devices if the IRQ is disabled, then the
> shared interrupt case can be handled as well.  However, there were complaints
> about the patch when Ingo had device polling included, as opposed to just
> IRQ mitigation.
>

I dont think youve followed the discussions too well and normally i
wouldnt respond but you addressed me. Ingos netdevice polling is not the
right approach, please look at NAPI and read the paper. NAPI does
all what youve been suggesting. We are not even discussing that at this
point. We are discussing the sledgehammer effect and how you could break a
finger or two trying to kill that fly with it. The example above
illustrates it.

cheers,
jamal


