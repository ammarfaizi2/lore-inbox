Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291635AbSBMM4X>; Wed, 13 Feb 2002 07:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291625AbSBMM4N>; Wed, 13 Feb 2002 07:56:13 -0500
Received: from [195.63.194.11] ([195.63.194.11]:53511 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S291635AbSBMM4A>; Wed, 13 Feb 2002 07:56:00 -0500
Message-ID: <3C6A624D.30601@evision-ventures.com>
Date: Wed, 13 Feb 2002 13:55:41 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: jgarzik@mandrakesoft.com, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.5.4 i810_audio, bttv, working at all.
In-Reply-To: <3C6A57CE.9010107@evision-ventures.com>	<3C6A5D79.33C31910@mandrakesoft.com>	<3C6A5EDB.40908@evision-ventures.com> <20020213.044545.95505962.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

>   From: Martin Dalecki <dalecki@evision-ventures.com>
>   Date: Wed, 13 Feb 2002 13:40:59 +0100
>
>   Of course I admit that I have taken the easy shoot here. But it wasn't 
>   possible
>   to me to deduce the proper thing to do by looking at the patches.
>   This is the usual way I deal with API changes: Have a look at what has 
>   been done
>   to the other candidates and do the analogous thing where you need it.
>   
>The API hasn't changed, it is being enforced.  The PCI DMA api
>has existed for years.  Please read Documentation/DMA-mapping.txt
>so that you may learn how to properly convert drivers.
>
>   But please just show me a non x86 architecture which is using the 
>   i810_audio driver!
>
>Because if all drivers are consistently using the portable interfaces,
>people writing new drivers will know exactly what to do.
>
Agred. I see now in patch-2.5.2 and the changes to ymfpci.c how to deal 
with this.
I was already suspicious that the continuous back and forth address 
space conversion
in bttv.c could be dealt with by just doing it once at initialization 
time and storing both
the physical and virtuall mapping. Will do it, when I have pyhsical 
access to the corresponding
hardware at hand.



