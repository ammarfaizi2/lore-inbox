Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265029AbUHMMY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbUHMMY0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 08:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265038AbUHMMY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 08:24:26 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:8132 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265029AbUHMMYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 08:24:23 -0400
Date: Fri, 13 Aug 2004 14:24:18 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, linux-kernel@vger.kernel.org,
       greg@kroah.com, mdharm-usb@one-eyed-alien.net
Subject: Re: [2.6 patch] let W1 select NET
Message-ID: <20040813122418.GC13377@fs.tum.de>
References: <20040813101717.GS13377@fs.tum.de> <Pine.LNX.4.58.0408131231480.20635@scrub.home> <1092394019.12729.441.camel@uganda> <Pine.LNX.4.58.0408131253000.20634@scrub.home> <20040813110137.GY13377@fs.tum.de> <Pine.LNX.4.58.0408131312390.20634@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408131312390.20634@scrub.home>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2004 at 02:11:28PM +0200, Roman Zippel wrote:

> Hi,

Hi Roman,

> On Fri, 13 Aug 2004, Adrian Bunk wrote:
> 
> > But the similar case of USB_STORAGE selecting SCSI is an example where 
> > select is a big user-visible improvement over depends.
> 
> comment "USB storage requires SCSI"
> 	depends on SCSI=n
> 
> That's also user visible and doesn't confuse the user later, why he can't 
> deselect SCSI.

that's exactly what we have in 2.4, and it's definitely worse that the 
select.

> Abusing select is really the wrong answer. What is needed is an improved 
> user interface, which allows to search through the kconfig information or 
> even can match hardware information to a driver and aids the user in 
> selecting the required dependencies.
> Keeping the kconfig database clean and making kernel configuration easier 
> are really two separate problems and we shouldn't sacrifice the former for 
> the latter.

Currently there's no better choice then "abusing select".

As soon as your improved user interface is included, I'm willing to help 
to evaluate which select's should be turned back into dependencies.

> bye, Roman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

