Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263997AbTCWX04>; Sun, 23 Mar 2003 18:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263999AbTCWX04>; Sun, 23 Mar 2003 18:26:56 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:39335
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263997AbTCWX0z>; Sun, 23 Mar 2003 18:26:55 -0500
Subject: Re: Query about SIS963 Bridges
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John M Collins <jmc@xisl.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E7E43C3.2080605@xisl.com>
References: <3E7E43C3.2080605@xisl.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048467041.10727.100.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Mar 2003 00:50:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-23 at 23:31, John M Collins wrote:
> I've just got a new machine (2.5 GHz pentium lots of RAM and disk space) 
> which has one of these SIS963 Southbridge creatures and I get the 
> message on booting a 2.4.19ish sort of kernel.

The SiS963 is currently a winputer. 

> Alas it's very clear that it isn't transparent and I can't get to half 
> of the PCI stuff - worst of all the built-in Ethernet and any Ethernet 
> card I plug in. It would seem that it isn't too transparent as the 
> reported IRQ and IOMEM assignments for the devices are all scrambled.

One possibility is the system expects ACPI to untangle that mess and set
up the bridge. You could certainly stuff realistic looking ranges into
it, set IO/MEM and master and see what happens then

What would be a useful starting point would be to see what 
lspci -vxx and lspci -vxx -H1 think

