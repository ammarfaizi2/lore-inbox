Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269232AbRHNMGL>; Tue, 14 Aug 2001 08:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270594AbRHNMGB>; Tue, 14 Aug 2001 08:06:01 -0400
Received: from Bf824.pppool.de ([213.7.248.36]:22923 "HELO localhost")
	by vger.kernel.org with SMTP id <S269232AbRHNMF5>;
	Tue, 14 Aug 2001 08:05:57 -0400
Date: Tue, 14 Aug 2001 14:05:59 +0200 (CEST)
From: Peter Koellner <peter@mezzo.net>
To: benjilr@free.fr
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem with PCMCIA and kernel 2.4.x
In-Reply-To: <997777753.3b78e159b004c@imp.free.fr>
Message-ID: <Pine.LNX.4.21.0108141400020.4006-100000@finnegan.do.mezzo.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2001 benjilr@free.fr wrote:

> I've a problem Because when the PCMCIA start, I've the message :
> PCI : NO IRQ known for interrupt pin A of device 01:02.0 please try
> using pci=bios, but when this parametre, IRQ is always unknow.
> 
> But when kernel Start, I've this message : 
> PCI : Probing PCI hardware
> Unknow bridge ressource 2: assuming transparent
> PCI : Using IRQ router PIIX [8086/244c] at 00:1f.0

i have the same effect with a sony PCG-FX209, kernel 2.4.8 and 
pcmcia 3.1.22. what is even stranger is that i have to invoke modprobe 
yenta_socket without any options first, or else the pci=biosirq option 
will not be recognized. so the startscript in /etc/init.d/pcmcia reads:

modprobe pcmcia_core
modprobe yenta_socket
modprobe yenta_socket pci=biosirq

-- 
peter koellner <peter@mezzo.net>


