Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292535AbSBTWD2>; Wed, 20 Feb 2002 17:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292538AbSBTWDS>; Wed, 20 Feb 2002 17:03:18 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:43495 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S292535AbSBTWDC>; Wed, 20 Feb 2002 17:03:02 -0500
Date: Wed, 20 Feb 2002 15:20:11 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: ioremap()/PCI sickness in 2.4.18-rc2 (FIXED ALMOST)
Message-ID: <20020220152011.A1252@vger.timpanogas.org>
In-Reply-To: <20020220103320.A32211@vger.timpanogas.org> <20020220103539.B32211@vger.timpanogas.org> <3C73DC34.E83CCD35@mandrakesoft.com> <20020220.093034.112623671.davem@redhat.com> <20020220110004.A32431@vger.timpanogas.org> <20020220145449.A1102@vger.timpanogas.org> <3C741A44.94FE4F56@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C741A44.94FE4F56@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, Feb 20, 2002 at 04:51:00PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2002 at 04:51:00PM -0500, Jeff Garzik wrote:
> "Jeff V. Merkey" wrote:
> > regions of memory.  I would propose that the maintainer of
> > vmalloc.c look at using 48 bit PTE entries or some other solution
> > as a way to alloc larger virtual address frames when the system has
> > a lot of physical memory.  It's seems pretty lame to me for a machine
> > with 2 GB of physical memory not to have at lest 256 MB of address space
> > left over for address mapping.
> 
> Instead of constantly trying to map >32-bit addresses onto 32-bit
> processors, why not just get a 64-bit processor?
> 
> One constantly runs into limitations with highmem...
> 
> 	Jeff

Sigh .... I am only using 2 GB on a 4GB capable processor (actually 
a 64 GB capable processor).  Looks like a patch is needed.  Who is 
maintaining vmalloc.c at present so I know who to submit a patch 
to?

Jeff


> 
> 
> 
> -- 
> Jeff Garzik      | "Why is it that attractive girls like you
> Building 1024    |  always seem to have a boyfriend?"
> MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
>                  |             - BBC TV show "Coupling"
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
