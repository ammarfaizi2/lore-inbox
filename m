Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262237AbRE1UOu>; Mon, 28 May 2001 16:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263136AbRE1UOj>; Mon, 28 May 2001 16:14:39 -0400
Received: from avocet.mail.pas.earthlink.net ([207.217.121.50]:57798 "EHLO
	avocet.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S262237AbRE1UOf>; Mon, 28 May 2001 16:14:35 -0400
From: "Christopher B. Liebman" <liebman@sponsera.com>
To: "Jens Axboe" <axboe@suse.de>,
        "Mark Hahn" <hahn@coffee.psychology.mcmaster.ca>
Cc: "Acpi@Phobos. Fachschaften. Tu-Muenchen. De" 
	<acpi@phobos.fachschaften.tu-muenchen.de>,
        <linux-kernel@vger.kernel.org>, <alan@lxorguk.ukuu.org.uk>,
        <andre@linux-ide.org>
Subject: RE: [patch]: ide dma timeout retry in pio
Date: Mon, 28 May 2001 16:13:15 -0400
Message-ID: <EAEOIAEILFNMCKKHDGFGEEBNCAAA.liebman@sponsera.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.10.10105281533400.25183-100000@coffee.psychology.mcmaster.ca>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think that this may be an issue with ACPI processor power saving...  I
have documented issues with ide DMA timeouts when the processor is put into
the C3 power state.  One of the things that happens in this state is that
buss master arbitration is *disabled*.....  bus master activity is
*supposed* to transition the system back to a C0 power state.  I'll bet
there are some issues with the Linux IDE dma and disabling bus master
arbitration......  ideas?  thoughts?  patches? ;-)

	-- Chris

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Mark Hahn
>
> I seem to recall Andre saying that the problem arises when the
> ide DMA engine looses PCI arbitration during a burst.  shorter
> bursts would seem like the best workaround if this is the problem...
>

