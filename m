Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131426AbRAHDHi>; Sun, 7 Jan 2001 22:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132462AbRAHDH2>; Sun, 7 Jan 2001 22:07:28 -0500
Received: from snark.wizard.com ([209.170.216.3]:23823 "EHLO snark.wizard.com")
	by vger.kernel.org with ESMTP id <S131426AbRAHDHX>;
	Sun, 7 Jan 2001 22:07:23 -0500
Date: Sun, 7 Jan 2001 18:57:53 -0800
From: A Guy Called Tyketto <tyketto@wizard.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FW: compile problem in 2.4.0-ac3
Message-ID: <20010107185753.A3104@wizard.com>
In-Reply-To: <20010107150240.A7070@wizard.com> <9034.978914532@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.13i
In-Reply-To: <9034.978914532@ocs3.ocs-net>; from kaos@ocs.com.au on Mon, Jan 08, 2001 at 11:42:12AM +1100
X-Operating-System: Linux/2.2.17 (i586)
X-uptime: 6:57pm  up  1:42,  6 users,  load average: 0.49, 0.33, 0.16
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-PGP-Keys: see http://www.omnilinx.net/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 11:42:12AM +1100, Keith Owens wrote:
> On Sun, 7 Jan 2001 15:02:40 -0800, 
> A Guy Called Tyketto <tyketto@wizard.com> wrote:
> >I'm still seeing 
> >
> >#include <linuxpi.h>
> >
> >        at line 25 of acpi_ksyms.c. This is also the same line, in 
> >patch-2.4.0-ac2 (counted the lines of each). Neither patches compile from this.
> 
> Not happening here.  -ac2 and -ac3 have the same text.
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.4.0/drivers/acpi/acpi_ksyms.c linux.ac/drivers/acpi/acpi_ksyms.c
> --- linux-2.4.0/drivers/acpi/acpi_ksyms.c       Thu Jan  1 01:00:00 1970
> +++ linux.ac/drivers/acpi/acpi_ksyms.c  Wed Jan  3 16:49:59 2001
> @@ -0,0 +1,91 @@
> +/*
> + *  ksyms.c - ACPI exported symbols
> + *
> + *  Copyright (C) 2000 Andrew Grover
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/acpi.h>	<== line 25
> +#include "acpi.h"
> 
> You have corrupted your patch and/or source.

        yep.. you were right. patch was corrupted. Just grabbed -ac4, and it 
cleanly applied and compiled. Thanks for the help! :)

                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
