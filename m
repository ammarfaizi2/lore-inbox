Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315606AbSFOV6g>; Sat, 15 Jun 2002 17:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315607AbSFOV6f>; Sat, 15 Jun 2002 17:58:35 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26639 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315606AbSFOV6e>; Sat, 15 Jun 2002 17:58:34 -0400
Date: Sat, 15 Jun 2002 14:58:45 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Paul Mackerras <paulus@samba.org>
cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>
Subject: Re: Cardbus
In-Reply-To: <15626.43392.825029.986506@argo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.44.0206151453360.3479-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 15 Jun 2002, Paul Mackerras wrote:
>
> IIRC someone told me that we had to do the "assuming transparent" bit
> because of buggy PCI-PCI bridges used on some PCs.  Can anyone
> enlighten me on the details of that?

It has nothing to do with "buggy" PCI-PCI bridges, and everything to do
with the fact that a lot of bridges seem to extend on the official PCI
bridge interface in various ways. In particular, it seems to be fairly
common to have the _real_ bridging information in the chip-specific range
(PCI config area 0x40+) instead of in the official "2 mem resources, 2 IO
resources" place.

I think even some bog-standard Intel PCI bridge did exactly this. But all
my pdf files are at work right now.

			Linus

