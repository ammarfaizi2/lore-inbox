Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290310AbSBKUrl>; Mon, 11 Feb 2002 15:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290386AbSBKUrb>; Mon, 11 Feb 2002 15:47:31 -0500
Received: from 24.213.60.123.up.mi.chartermi.net ([24.213.60.123]:31537 "EHLO
	front1.chartermi.net") by vger.kernel.org with ESMTP
	id <S290310AbSBKUrU>; Mon, 11 Feb 2002 15:47:20 -0500
Content-Type: text/plain; charset=US-ASCII
From: reddog83 <reddog83@chartermi.net>
Reply-To: reddog83@chartermi.net
To: "Paul Fulghum" <paulkf@microgate.com>
Subject: Re: [PATCH] 2.5.3-dj5 synclink.c fix so that it compiles
Date: Mon, 11 Feb 2002 15:48:23 -0500
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <auto-000058815980@front2.chartermi.net> <001701c1b312$24448ca0$0c00a8c0@diemos>
In-Reply-To: <001701c1b312$24448ca0$0c00a8c0@diemos>
Cc: linux-kernel@vger.kernel.org
X-PRIORITY: 2 (High)
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <auto-000058467594@front1.chartermi.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul-
That is understandable. I had  the same guess as you when I made this patch. 
Why is ths synclink.c driver using DMA Mapping. After I took that line out I 
was fine becuase my system is fine. 

On Monday 11 February 2002 10:38 am, you wrote:
> > This is a temp fix for thje synclink.c file in drivers/char it work's for
>
> me
>
> > so DJ will you please apply this patch.
> > Thank you Victor Torres.
> > All it does it removes the #error please convert me to
> > Documentation/DMA-mapping.txt
> > it compiles and work's great for me.
> > Please apply
>
> There is nothing in the DMA-mapping.txt that
> applies to the PCI version of the synclink adapter
> (which does not do DMA to/from system memory).
>
> The ISA version of the synclink adapter does do
> ISA DMA bus master transfers. After reading
> DMA-mapping.txt twice it is unclear what changes
> need to be applied. The documentation seems to imply
> that ISA devices need to make some pci_xxx calls.
> I'm not sure how this works when there is no PCI bus.
>
> For now, removing the #error line should work fine
> for the PCI adapter and probably for the ISA as well.
>
> I will look at this again as time allows.
>
> I usually wait 6-12 months after the new development
> kernel opens before attempting to sync my drivers
> to the latest changes. This avoids most of the eat-your-file-system
> phase, prevents wasting time chasing after a rapidly changing API,
> and still leaves another 12 months for tweaking.
>
> Paul Fulghum, paulkf@microgate.com
> Microgate Corporation, www.microgate.com
