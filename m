Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289306AbSCCWRP>; Sun, 3 Mar 2002 17:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289484AbSCCWRH>; Sun, 3 Mar 2002 17:17:07 -0500
Received: from zeus.kernel.org ([204.152.189.113]:20169 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S289306AbSCCWQ5>;
	Sun, 3 Mar 2002 17:16:57 -0500
Date: Sat, 2 Mar 2002 16:15:16 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
To: Stephen Mollett <molletts@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Handling of bogus PCI bus numbering
In-Reply-To: <E16h8lH-000PtZ-0W@anchor-post-32.mail.demon.net>
Message-ID: <Pine.LNX.4.44.0203021613320.392-100000@chaos.tp1.ruhr-uni-bochum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Mar 2002, Stephen Mollett wrote:

> I've got an IBM Thinkpad 240 and the BIOS incorrectly assigns bus number 0 to 
> the CardBus (obviously, bus 0 is the primary internal PCI bus). Because of 
> this, it's impossible to use CardBus devices - when one is inserted, its 
> device number (00:00.0) collides with the 82443BX Northbridge and Card 
> Services understandably gets rather confused, thinking I've just plugged in a 
> 440BX chip... ahem.

Could you replace "#undef DEBUG" with "#define DEBUG" in drivers/pci/pci.c 
and arch/i386/kernel/pci-i386.h, rebuild the kernel and send "dmesg" 
output after rebooting/inserting the card?

--Kai


