Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316799AbSFDVSe>; Tue, 4 Jun 2002 17:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316823AbSFDVSe>; Tue, 4 Jun 2002 17:18:34 -0400
Received: from air-2.osdl.org ([65.201.151.6]:39815 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S316799AbSFDVSb>;
	Tue, 4 Jun 2002 17:18:31 -0400
Date: Tue, 4 Jun 2002 14:14:26 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: "David S. Miller" <davem@redhat.com>
cc: <anton@samba.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.19] Oops during PCI scan on Alpha
In-Reply-To: <20020604.141412.112289324.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0206041413530.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 4 Jun 2002, David S. Miller wrote:

>    From: Patrick Mochel <mochel@osdl.org>
>    Date: Tue, 4 Jun 2002 14:10:27 -0700 (PDT)
>    
>    > You people are blowing this shit WAY out of proportion.  Just fix the
>    > bug now and reinplement the initcall hierarchy in a seperate changeset
>    > so people can actually get work done in the 2.5.x tree while you do
>    > that ok?
>    
>    Fine. Use Ivan's; it's appended below, and will be in BK soon. 
>    
>    -subsys_initcall(sys_bus_init);
>    +core_initcall(sys_bus_init);
> 
> Does sys_bus_init require the generic bus layer to be initialized
> first?

Yes, and it is in drivers/base/bus.c just before sys_bus_init is called.

	-pat

