Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314443AbSEBOAu>; Thu, 2 May 2002 10:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314444AbSEBOAt>; Thu, 2 May 2002 10:00:49 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:64270 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S314443AbSEBOAs>; Thu, 2 May 2002 10:00:48 -0400
Date: Thu, 2 May 2002 16:00:08 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Andrea Arcangeli <andrea@suse.de>, Ralf Baechle <ralf@uni-koblenz.de>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: discontiguous memory platforms
In-Reply-To: <E172u39-0001wn-00@starship>
Message-ID: <Pine.LNX.4.21.0205021539460.23113-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 1 May 2002, Daniel Phillips wrote:

> > Just to throw in an alternative: On m68k we map currently everything
> > together into a single virtual area. This means the virtual<->physical
> > conversion is a bit more expensive and mem_map is simply indexed by the
> > the virtual address.
> 
> Are you talking about mm_ptov and friends here?  What are the loops for?

It simply searches through all memory nodes, it's not really efficient.

> Could you please describe the most extreme case of physical discontiguity
> you're handling?

I can't assume anything. I'm thinking about calculating the table
dynamically and patching the kernel at bootup, we are already doing
something similiar in the Amiga/ppc kernel.

bye, Roman

