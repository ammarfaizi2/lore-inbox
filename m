Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129114AbRBBNwO>; Fri, 2 Feb 2001 08:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129152AbRBBNwE>; Fri, 2 Feb 2001 08:52:04 -0500
Received: from pcow029o.blueyonder.co.uk ([195.188.53.123]:56583 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S129114AbRBBNvu>;
	Fri, 2 Feb 2001 08:51:50 -0500
Date: Fri, 2 Feb 2001 13:46:42 +0000
From: Michael Pacey <michael@wd21.co.uk>
To: drew@drewb.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2 SCSI controllers causing boot problems...
Message-ID: <20010202134642.A344@kermit.wd21.co.uk>
In-Reply-To: <14970.34641.120958.857239@champ.drew.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <14970.34641.120958.857239@champ.drew.net>; from drew@drewb.com on Fri, Feb 02, 2001 at 10:09:21 +0000
X-Mailer: Balsa 1.0.pre5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 02 Feb 2001 10:09:21 Drew Bertola wrote:
> 
> I know I've seen this in the past, but the answer slips my mind and I
> can't find anything in the archives.
> 
> I've just set up a box w/ an aic7xxx card.  The boot drive hangs off
> that card.  During installation, the boot drive is sda.  Lilo contains
> "root=/dev/sda8".  
> 
> I compiled a new kernel with the 3ware raid driver.  When I rebooted,
> the 3ware card driver must have been loaded first; /dev/sda8 was no
> longer the root device.
> 
> How do I control the device designations during boot?
>

Drew,

If you check the archive's I've had a similar problem.

Possible answers:

Compile the to-be-loaded-2nd driver as a module and keep the first builtin
Use devfs (it lets you pass a 'scsi=driver1:driver2:...' to the kernel,
controlling load order)

There are devfs 2.2 patches and 2.4.1 includes devfs natively; I chose
2.4.1 and it worked.

--
Michael Pacey
michael@wd21.co.uk
ICQ: 105498469

wd21 ltd - world domination in the 21st century

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
