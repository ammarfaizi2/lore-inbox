Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287017AbSABWIe>; Wed, 2 Jan 2002 17:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287045AbSABWI1>; Wed, 2 Jan 2002 17:08:27 -0500
Received: from svr3.applink.net ([206.50.88.3]:21256 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S287023AbSABWIK>;
	Wed, 2 Jan 2002 17:08:10 -0500
Message-Id: <200201022208.g02M81Sr022656@svr3.applink.net>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: "ChristianK."@t-online.de (Christian Koenig),
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Date: Wed, 2 Jan 2002 16:04:20 -0600
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020102151539.A14925@thyrsus.com> <16Lstn-0eAVxAC@fwd07.sul.t-online.com>
In-Reply-To: <16Lstn-0eAVxAC@fwd07.sul.t-online.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 January 2002 15:28, Christian Koenig wrote:
> Hi,
>
> On Wednesday 02 January 2002 21:15, Eric S. Raymond wrote:
> > Is there any way to safely probe a PCI motherboard to determine whether
> > or not it has ISA cards present, or ISA card slots?
> >
> > Note: the question is *not* about a probe for whether the board has an
> > ISA bridge, but a probe for the presence of actual ISA cards (or slots).
> >
> > (Yes, I'm working on a smart autoconfigurator.  It's a development of
> > Giacomo Catenazzi's code, but able to use the CML2 deduction engine.)
>
> Nope, AFAIK even if the motherboard dosn't have ISA-Slots, the ISA-like
> chipset (DMA/old IRQ/Timer) is still present because off compatiblity
> reasons.

Here's a good quotation from the lm_sensors man page:

2.3 I don't have an ISA bus!

    We promise, you do, even if you don't have any old ISA slots.
The "ISA Bus" exists in your computer even if you don't have ISA slots;
it is simply a memory-mapped area, 64KB in size (0x0000 - 0xFFFF)
where many "legacy" functions, such as keyboard and interrupt controllers,
are found. It isn't necessarily a separate physical bus.
See the file /proc/ioports for a list of devices living on
the "ISA Bus" in your system. If you don't like the term "ISA Bus"
think "I/O Space".


>
> But if you only want to know if a specified IO-range is on an ISA-card you
> could try to turn off the PCI-ISA brige, done this with Intel chipset
> before (they call this power saveing mode).
>
> MfG, Christian König.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
timothy.covell@ashavan.org.
