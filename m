Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129765AbRAUQHZ>; Sun, 21 Jan 2001 11:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129744AbRAUQHG>; Sun, 21 Jan 2001 11:07:06 -0500
Received: from m263-mp1-cvx1c.col.ntl.com ([213.104.77.7]:17156 "EHLO
	[213.104.77.7]") by vger.kernel.org with ESMTP id <S129593AbRAUQGz>;
	Sun, 21 Jan 2001 11:06:55 -0500
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: <acpi@phobos.fachschaften.tu-muenchen.de>, <linux-kernel@vger.kernel.org>,
        <torvalds@transmeta.com>
Subject: Re: [PATCH] linux-2.4.1-pre9/include/linux/acpi.h broke acpid compilation
In-Reply-To: <20010121002319.A8447@adam.yggdrasil.com>
From: "John Fremlin" <vii@altern.org>
Date: 21 Jan 2001 16:05:20 +0000
In-Reply-To: "Adam J. Richter"'s message of "Sun, 21 Jan 2001 00:23:19 -0800"
Message-ID: <m2puhgriv3.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 "Adam J. Richter" <adam@yggdrasil.com> writes:

> linux-2.4.1-pre9/include/linux/acpi.h contains declares the routine
> acpi_get_rsdp_ptr returning the kernel-only type "u64", without
> bracketing the declaration in "#ifdef __KERNEL__...#endif".
> Consequently, a user level program that attempts to include
> <linux/acpi.h>, such as acpid, gets a compilation error.  The
> following patch fix the problem by stretching an earlier "#ifdef
> __KERNEL__...#endif" area to cover the acpi_get_rsdp_ptr
> declaration.

I sent a similar patch to the maintainer andy_henroid@yahoo.com on
December 29 but have received no response so far.

-- 

	http://www.penguinpowered.com/~vii
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
