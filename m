Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317150AbSEXOvH>; Fri, 24 May 2002 10:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317152AbSEXOvG>; Fri, 24 May 2002 10:51:06 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:57778 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317150AbSEXOvF>;
	Fri, 24 May 2002 10:51:05 -0400
Date: Fri, 24 May 2002 16:50:21 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] New driver for Artop [Acard] controllers.
Message-ID: <20020524165021.B10656@ucw.cz>
In-Reply-To: <Pine.SOL.4.30.0205241620440.16894-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 04:29:39PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Hi!
> 
> I have a very quick look over patch/driver... looks quite ok...
> 
> But it doesn't support multiple controllers.

Yes, right! That's a bug. Ahh, that's why all the drivers use the PCI
device id over and over and over in the sources ...

> We should add 'unsigned long private' to 'ata_channel struct' and
> store index in the chipset table there.

That'd be great. Though I prefer void*. Looks like "drive_data" is
intended for that purpose. Martin: How about renaming this to "private"
and a comment "solely for use by chip-specific drivers"?

A private member in the ata_pci_device[] struct would be also very
useful. Or is the "extra" field for that?

> You can remove duplicate entries from module data table.

I wonder how they got there ...

> BTW: please don't touch pdc202xx.c I am playing with it...

Ok, I won't. Send it to me for comments later.

-- 
Vojtech Pavlik
SuSE Labs
