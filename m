Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284795AbSABVsE>; Wed, 2 Jan 2002 16:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284538AbSABVry>; Wed, 2 Jan 2002 16:47:54 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:49415 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S284542AbSABVrm>; Wed, 2 Jan 2002 16:47:42 -0500
Message-ID: <3C337EF1.4C7C72AB@zip.com.au>
Date: Wed, 02 Jan 2002 13:43:13 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
CC: vda <vda@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: Extern variables in *.c files
In-Reply-To: <02010216180403.01928@manta> <Pine.LNX.4.43.0201021322120.30079-100000@waste.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:
> 
> On Wed, 2 Jan 2002, vda wrote:
> 
> > I grepped kernel *.c (not *.h!) files for extern variable definitions.
> > Much to my surprize, I found ~1500 such defs.
> >
> > Isn't that bad C code style? What will happen if/when type of variable gets
> > changed? (int->long).
> 
> Yes; Int->long won't change anything on 32-bit machines and will break
> silently on 64-bit ones. The trick is finding appropriate places to put
> such definitions so that all the things that need them can include them
> without circular dependencies.
> 

Isn't there some way to get the linker to detect the differing
sizes?

-
