Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266046AbTGDPGJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 11:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266048AbTGDPGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 11:06:09 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:60566 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S266046AbTGDPGH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 11:06:07 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 4 Jul 2003 08:12:50 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Arjan van de Ven <arjanv@redhat.com>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mj@ucw.cz,
       alan@redhat.com
Subject: Re: [PATCH] Re: VIA PCI IRQ router bug fix
In-Reply-To: <1057303907.5801.0.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.55.0307040808290.4800@bigblue.dev.mcafeelabs.com>
References: <5F106036E3D97448B673ED7AA8B2B6B36C352C@scl-exch2k.phoenix.com>
  <3F04C1AA.80107@pobox.com> <1057303907.5801.0.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jul 2003, Arjan van de Ven wrote:

>
> >
> >  static int pirq_via_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
> >  {
> > -	write_config_nybble(router, 0x55, pirq, irq);
> > +	write_config_nybble(router, 0x55, pirq == 4 ? 5 : pirq, irq);
> >  	return 1;
> >  }
>
>
> you missed the
> > +        return (x >> 4);
> in the original patch... so your code is NOT identical.

It's ok :

nybble(0x57, 1) == nybble(0x55, 5)



- Davide

