Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262793AbRE0IR5>; Sun, 27 May 2001 04:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262796AbRE0IRi>; Sun, 27 May 2001 04:17:38 -0400
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:39553 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S262793AbRE0IRZ>; Sun, 27 May 2001 04:17:25 -0400
Date: Sun, 27 May 2001 09:17:15 +0100 (BST)
From: James Sutherland <jas88@cam.ac.uk>
X-X-Sender: <jas88@yellow.csi.cam.ac.uk>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: <cesar.da.silva@cyberdude.com>, kernellist <linux-kernel@vger.kernel.org>
Subject: Re: Please help me fill in the blanks.
In-Reply-To: <3B1065FD.3F8D7EDF@mandrakesoft.com>
Message-ID: <Pine.SOL.4.33.0105270913110.8047-100000@yellow.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 May 2001, Jeff Garzik wrote:

> Cesar Da Silva wrote:
> > The features that I'm wondering about are:
> > * Dynamic Processor Resilience
>
> is this fault tolerance?  I think if a CPU croaks, you are dead.
>
> There are patches for hot swap cpu support, but I haven't seen any CPU
> fault tolerance patches that can handle a dead processor

The S/390 has this; presumably it applies to Linux as well as the other
supported OSs?

> > * Dynamic Memory Resilience
>
> RAM fault tolerance?  There was a patch a long time ago which detected
> bad ram, and would mark those memory clusters as unuseable at boot.
> However that is clearly not dynamic.
>
> If your memory croaks, your kernel will experience random corruptions

ECC can be supported by the hardware; no support for mapping out duff
banks on x86, but again S/390 may differ?

> > * Live Upgrade
>
> LOBOS will let one Linux kernel boot another, but that requires a boot
> step, so it is not a live upgrade.  so, no, afaik

Live SOFTWARE upgrade, or live HARDWARE upgrade? If the latter, things
like hotswap PCI, USB... and again the S/390?

> > * Service Location Protocol (SLP)
>
> don't know

Yes, I think so - mars_nwe surely needs this?

> > * TCP/IP Gratuitous ARP (RFC 2002)
>
> not sure

Isn't that how LVS clusters handle IP takeovers?

> > * Path MTU Discovery (RFC 1191)
>
> yes

With one or two RFC violations, yes.

Basically, most of those features relating to hardware resilience should
be usable with Linux on an S/390 - they are hardware features, though,
AFAICS?


James.

