Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265247AbTBBNQL>; Sun, 2 Feb 2003 08:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265249AbTBBNQL>; Sun, 2 Feb 2003 08:16:11 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:26255
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265247AbTBBNQK>; Sun, 2 Feb 2003 08:16:10 -0500
Subject: Re: Defect (Bug) Report
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
Cc: "John W. M. Stevens" <john@betelgeuse.us>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030202124911.GC30830@arthur.ubicom.tudelft.nl>
References: <20030202011223.GC5432@morningstar.nowhere.lie>
	 <1044178961.16853.9.camel@irongate.swansea.linux.org.uk>
	 <20030202124911.GC30830@arthur.ubicom.tudelft.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044195694.16853.22.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 02 Feb 2003 14:21:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-02-02 at 12:49, Erik Mouw wrote:
> What's the current wisdom with dual Athlon boards to get them stable?
> This is my list so far (for Asus A7M266-D):
> 
> - Plug in a PS/2 mouse even though you don't use it. It fixes certain
>   hardware problems.
> - Select "PnP OS = no" in the BIOS so all PCI devices (even the ones
>   behind the PCI-PCI bridge) get properly initialised.
> - Boot Linux with "noapic" to avoid random hangs.
> 
> Exact BIOS revision doesn't seem to matter. Any more suggestions?

BIOS revision matters too. With 1004 you need to set MP 1.1 not MP 1.4
and APIC works reliably. With 1007 it seems that isnt needed but people
report weird hangs. 1004 also won't POST with a broadcom ethernet card
in it.

The proper fix for the PS/2 mouse/IDE problem appears to be always
mapping out the page at 636-640K. Andi posted an ugly patch to handle
that, but doing it cleanly is trickier. 

Alan

