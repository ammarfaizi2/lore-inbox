Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315946AbSFPHLG>; Sun, 16 Jun 2002 03:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315971AbSFPHLF>; Sun, 16 Jun 2002 03:11:05 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32357 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S315946AbSFPHLF>; Sun, 16 Jun 2002 03:11:05 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
        Patrick Mochel <mochel@osdl.org>
Subject: Re: Cardbus
In-Reply-To: <Pine.LNX.4.44.0206151453360.3479-100000@home.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 Jun 2002 01:01:08 -0600
Message-ID: <m1d6urvhaj.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On Sat, 15 Jun 2002, Paul Mackerras wrote:
> >
> > IIRC someone told me that we had to do the "assuming transparent" bit
> > because of buggy PCI-PCI bridges used on some PCs.  Can anyone
> > enlighten me on the details of that?
> 
> It has nothing to do with "buggy" PCI-PCI bridges, and everything to do
> with the fact that a lot of bridges seem to extend on the official PCI
> bridge interface in various ways. In particular, it seems to be fairly
> common to have the _real_ bridging information in the chip-specific range
> (PCI config area 0x40+) instead of in the official "2 mem resources, 2 IO
> resources" place.

As additional detail this works for the bridge manufactures because they
can get the BIOS to do the hard work, and the os doesn't have to touch it.
For any component that isn't designed to be part of a plug-in card,
there isn't a compelling reason for the vendors to follow a standard
interface for configuring it.  Only the use case must follow a
standard interface.

Eric
