Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284810AbRLPU54>; Sun, 16 Dec 2001 15:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284816AbRLPU5r>; Sun, 16 Dec 2001 15:57:47 -0500
Received: from uunet-gw.macroscoop.nl ([195.193.201.73]:25352 "EHLO
	mondriaan.macroscoop.nl") by vger.kernel.org with ESMTP
	id <S284810AbRLPU5g>; Sun, 16 Dec 2001 15:57:36 -0500
From: "Pim Zandbergen" <P.Zandbergen@macroscoop.nl>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>,
        "Cristian CONSTANTIN" <constantin@fokus.gmd.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: aic7xxx freezes with kernel 2.4.13 - solved
Date: Sun, 16 Dec 2001 21:57:16 +0100
Message-ID: <NAEJLAMIFLGGOABFKHIDCEFHCAAA.P.Zandbergen@macroscoop.nl>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <200111262228.fAQMSrY52300@aslan.scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

For the archives: my problem is solved. The problem went away after
removing a (crashed) IDE disk and the HPT370 IDE controller it was
connected to. I replaced the faulty IDE disk with a SCSI disk and
now all my IDE and SCSI problems are gone.

Thanks for your input,
Pim

> >On Wed, Nov 07, 2001 at 04:20:17PM +0100, Pim Zandbergen wrote:
> >> Hi,
> >> 
> >> I've got a Dell PowerEdge 1300 with dual PIII's and dual aic7xxx
> >> controllers. One controller is onboard, the other is in a PCI slot.
> >> 
> >> The system is running Red Hat 7.1 with kernel 2.4.13.
> >> 
> >> Lately, this system is experiencing freezes that may last one or two
> >> minutes. These usually occur during heavy Samba activity. After the
> >> freeze, the system usually recovers, but by then, the Samba clients
> >> have timed out their operations.
> >> 
> >> Syslog shows the freezes are related to the SCSI subsystem. I'm having
> >> trouble interpreting this information. Is my hardware suspect or could
> >> this be a driver bug?
> >> 
> >> Syslog entries (with aic7xxx=verbose) showing the boot process and a
> >> system freeze can be found on
> >> 
> >> http://www.macroscoop.nl/~pim/aic7xxx/syslog.html (98.080 bytes) or
> >> http://www.macroscoop.nl/~pim/aic7xxx/syslog.gz   (6.410 bytes)
> 
> In the case of these traces, it appears that the bus is not up to
> snuff for the negotiated speed.  We're in data-out phase, our DMA
> engine is enabled, our FIFO is full of data to send, but the target
> has not requested any more data.  This means that either the controller
> missed a REQ or the target missed an ACK.  I would verify your cabling
> and termination.
 
