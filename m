Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271704AbRHQRVj>; Fri, 17 Aug 2001 13:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271696AbRHQRVa>; Fri, 17 Aug 2001 13:21:30 -0400
Received: from chaos.analogic.com ([204.178.40.224]:13440 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S271701AbRHQRVT>; Fri, 17 Aug 2001 13:21:19 -0400
Date: Fri, 17 Aug 2001 13:21:25 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: David Christensen <David_Christensen@Phoenix.com>
cc: Holger Lubitz <h.lubitz@internet-factory.de>, linux-kernel@vger.kernel.org
Subject: RE: Encrypted Swap
In-Reply-To: <D973CF70008ED411B273009027893BA401BE6BA9@irv-exch.phoenix.com>
Message-ID: <Pine.LNX.3.95.1010817131800.2216B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2001, David Christensen wrote:

> > > Ryan Mack proclaimed:
> > > > is running.  If the system is physically compromised, 
> > there is little way
> > > > I can think of to take root without having to at least reboot the
> > > > computer, thus destroying the unencrypted contents of RAM.
> > > 
> > > This is a myth. RAM survives rebooting, even after a quick 
> > power cycle
> > > most cells will probably still be ok. And with todays 
> > memory sizes, it
> > > would take a noticable amount of time to initialize all of 
> > it to a given
> > > value, so most systems don't do it (just testing some bytes of every
> > > megabyte instead).
> > > 
> > > Holger
> > > -
> > 
> > Errrm no. All BIOS that anybody would use write all memory found when
> > initializing the SDRAM controller. They need to because nothing,
> > refresh, precharge, (or if you've got it, parity/crc) will work
> > until every cell is exercised. A "warm-boot" is different. However,
> > if you hit the reset or the power switch, nothing in RAM survives.
> 
> Most modern firmware does NOT clear memory during POST, it takes too long.
> Certain compatibility areas are usually cleared (such as the 1st megabyte)
> but the rest is
> left as is, except for a few read/writes (usually on a megabyte boundary).
> The 
> exception to this rule is ECC systems.  They have to be written to make sure
> the 
> ECC information is correct.  
> 
> SDRAM memory sizing is usually done by reading an EEPROM on the SDRAM DIMM.
> The BIOS doesn't need to guess the correct timing values, it simply reads
> the EEPROM and programs the memory controller.  In the case of a BIOS that
> doesn't use EEPROM you might lose data as the BIOS iteratively tries 
> different memory timings and tests if they work.
> 
> I have done work implementing ACPI S3 (suspend-to-RAM) in DOS by simply
> hitting 
> the RESET button and restoring the memory controller settings.  The contents
> of 
> RAM have always been valid.
> 
> David Christensen
> 

I just posted working SDRAM controller initialization code. The SDRAM
controller must be initialized in a specific step-by-step manner or
else you don't even get to "restoring the memory controller settings".


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


