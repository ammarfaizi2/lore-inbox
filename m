Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292116AbSBTRnP>; Wed, 20 Feb 2002 12:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292124AbSBTRnE>; Wed, 20 Feb 2002 12:43:04 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:54758 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S292108AbSBTRmy>; Wed, 20 Feb 2002 12:42:54 -0500
Date: Wed, 20 Feb 2002 11:00:04 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: "David S. Miller" <davem@redhat.com>
Cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org,
        jmerkey@timpanogas.org
Subject: Re: ioremap()/PCI sickness in 2.4.18-rc2
Message-ID: <20020220110004.A32431@vger.timpanogas.org>
In-Reply-To: <20020220103320.A32211@vger.timpanogas.org> <20020220103539.B32211@vger.timpanogas.org> <3C73DC34.E83CCD35@mandrakesoft.com> <20020220.093034.112623671.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020220.093034.112623671.davem@redhat.com>; from davem@redhat.com on Wed, Feb 20, 2002 at 09:30:34AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David,

Someone had a thought that perhaps the Serverworks chipset is mapping 
addresses above the 4GB boundry.  Any thoughts on how to get around
this problem?  

Jeff


On Wed, Feb 20, 2002 at 09:30:34AM -0800, David S. Miller wrote:
>    From: Jeff Garzik <jgarzik@mandrakesoft.com>
>    Date: Wed, 20 Feb 2002 12:26:12 -0500
>    
>    type abuse aside, and alpha bugs aside, this looks ok... what is the
>    value of as->msize?
> 
> Jeff and Jeff, the problem is one of two things:
> 
> 1) when you have ~2GB of memory the vmalloc pool is very small
>    and this it the same place ioremap allocations come from
> 
> 2) the BIOS or Linus is not assigning resources of the device
>    properly, or it simple can't because the available PCI MEM space
>    with this much memory is too small
> 
> I note that one of the resources of the card is 16MB or so.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
