Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318274AbSGXXgn>; Wed, 24 Jul 2002 19:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318281AbSGXXgm>; Wed, 24 Jul 2002 19:36:42 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:41639 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S318274AbSGXXgm>; Wed, 24 Jul 2002 19:36:42 -0400
Date: Thu, 25 Jul 2002 00:39:44 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: type safe lists (was Re: PATCH: type safe(r) list_entry repacement: generic_out_cast)
Message-ID: <20020725003944.B8430@kushida.apsleyroad.org>
References: <20020723114703.GM11081@unthought.net.suse.lists.linux.kernel> <3D3E75E9.28151.2A7FBB2@localhost.suse.lists.linux.kernel> <p73d6tdtg2s.fsf@oldwotan.suse.de> <ahn4gl$347$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <ahn4gl$347$1@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Jul 24, 2002 at 09:00:05PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> >> As long as your pointers are 32bit this seems to be ok. But on 
> >> 64bit implementations pointers are not (unsigned long) so this cast 
> >> seems to be wrong.
> >
> >A pointer fits into unsigned long on all 64bit linux ports.
> >The kernel very heavily relies on that.
> 
> Not just the kernel, afaik.  I think it's rather tightly integrated into
> gcc internals too (ie pointers are eventually just converted to SI
> inside the compiler, and making a non-SI pointer would be hard). 

That can't be the case, as how would GCC represent 64-bit pointers on
platforms like the Alpha, which support 64-bit, 32-bit, 16-bit and 8-bit
types?  64-bits must be DImode simply because QImode is the smallest
mode, and required for the 8-bit type.

-- Jamie

