Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965029AbWA1RLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965029AbWA1RLm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 12:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWA1RLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 12:11:42 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:20378 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S932441AbWA1RLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 12:11:41 -0500
Date: Sat, 28 Jan 2006 18:11:48 +0100
From: Luca <kronos@kronoz.cjb.net>
To: Jan De Luyck <lkml@kcore.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suspend to RAM: help with whitelist wanted
Message-ID: <20060128171148.GA5363@dreamland.darkstar.lan>
References: <20060126213611.GA1668@elf.ucw.cz> <20060127232207.GB1617@elf.ucw.cz> <20060128155800.GA3064@dreamland.darkstar.lan> <200601281704.19050.lkml@kcore.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601281704.19050.lkml@kcore.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Sat, Jan 28, 2006 at 05:04:18PM +0100, Jan De Luyck ha scritto: 
> On Saturday 28 January 2006 16:58, Luca wrote:
> > - I must stop acpid before suspending otherwise it will get a "power
> >   button pressed" event on resume and shutdown the machine; not related
> >   to s2ram though.
> 
> You can fix that by e.g creating a file /tmp/acpi_sleep, and checking in the 
> powerbutton routine if the file is present. Delete it if it is present, and 
> just shutdown the machine if not. 
> 
> I have to do that too on my Acer TM803.

Well this is not a big deal, my suspend script just does:

/etc/init.d/acpid stop
echo mem > /sys/power/state
/etc/init.d/acpid start

Luca
-- 
Home: http://kronoz.cjb.net
La vasca da bagno fu inventata nel 1850, il telefono nel 1875.
Se fossi vissuto nel 1850, avrei potuto restare in vasca per 25 anni
senza sentir squillare il telefono
