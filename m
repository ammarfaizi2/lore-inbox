Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287874AbSBMRTu>; Wed, 13 Feb 2002 12:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287882AbSBMRTl>; Wed, 13 Feb 2002 12:19:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31246 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S287874AbSBMRT0>;
	Wed, 13 Feb 2002 12:19:26 -0500
Message-ID: <3C6AA01A.51517C48@mandrakesoft.com>
Date: Wed, 13 Feb 2002 12:19:22 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "David S. Miller" <davem@redhat.com>, dalecki@evision-ventures.com,
        linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.5.4 i810_audio, bttv, working at all.
In-Reply-To: <Pine.LNX.4.33.0202131043230.13632-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> But many of them are barely working, written by people who don't care
> about the rest of the kernel (or even about the driver itself, they just
> wanted to have a working machine and forget about it), and if we make
> those kinds of drivers do extra work, it's just not going to work.

Which is why, IMO, we should endeavor to make drivers as cookie-cutter
and dirt simple to create as possible.  It will probably take many
months, but I would like to continually factor out from the net drivers
not only common code but -design patterns-.

As an experiment a couple months ago, I got most of the PCI net drivers
down to ~200-300 lines of C code apiece, by factoring out common code
patterns into M4 macros.  "m4 netdrivers.m4 epic100.tmpl > epic100.c"

I would prefer to make drivers so dirt simple that people don't need to
worry about details like PCI DMA API changes...

	Jeff, dreams on

-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
