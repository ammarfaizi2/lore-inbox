Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316826AbSFDVd2>; Tue, 4 Jun 2002 17:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316797AbSFDVd1>; Tue, 4 Jun 2002 17:33:27 -0400
Received: from air-2.osdl.org ([65.201.151.6]:53383 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S316826AbSFDVd0>;
	Tue, 4 Jun 2002 17:33:26 -0400
Date: Tue, 4 Jun 2002 14:29:21 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: "David S. Miller" <davem@redhat.com>
cc: <anton@samba.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.19] Oops during PCI scan on Alpha
In-Reply-To: <20020604.142312.23013040.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0206041427260.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 4 Jun 2002, David S. Miller wrote:

>    From: Patrick Mochel <mochel@osdl.org>
>    Date: Tue, 4 Jun 2002 14:14:26 -0700 (PDT)
> 
>    On Tue, 4 Jun 2002, David S. Miller wrote:
>    
>    > Does sys_bus_init require the generic bus layer to be initialized
>    > first?
>    
>    Yes, and it is in drivers/base/bus.c just before sys_bus_init is called.
> 
> Linkers are allowed to reorder object files unless you tell them
> explicitly not to.
> 
> This is why you need to put this stuff into a seperate initcall level.
> This is precisely why I suggest postcore_initcall as the fix.

Ok, how about just keeping it a subsys_initcall, like it was in the first 
place? 

	-pat

