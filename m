Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314284AbSEBIvO>; Thu, 2 May 2002 04:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314285AbSEBIvN>; Thu, 2 May 2002 04:51:13 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:10762 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S314284AbSEBIvL>; Thu, 2 May 2002 04:51:11 -0400
Date: Thu, 2 May 2002 10:50:55 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: Ralf Baechle <ralf@uni-koblenz.de>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: discontiguous memory platforms
In-Reply-To: <20020502032725.S11414@dualathlon.random>
Message-ID: <Pine.LNX.4.21.0205021041570.23113-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2 May 2002, Andrea Arcangeli wrote:

> What I
> care about is not to clobber the common code with additional overlapping
> common code abstractions.

Just to throw in an alternative: On m68k we map currently everything
together into a single virtual area. This means the virtual<->physical
conversion is a bit more expensive and mem_map is simply indexed by the
the virtual address.
It works nicely, it just needs two small patches in the initializition
code, which aren't integrated yet. I think it's very close to what Daniel
wants, only that the logical and virtual address are identical.

bye, Roman

