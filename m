Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132210AbRAVRxz>; Mon, 22 Jan 2001 12:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132426AbRAVRxp>; Mon, 22 Jan 2001 12:53:45 -0500
Received: from selene.cps.intel.com ([192.198.165.10]:41995 "EHLO
	selene.cps.intel.com") by vger.kernel.org with ESMTP
	id <S132210AbRAVRxh>; Mon, 22 Jan 2001 12:53:37 -0500
Message-ID: <4148FEAAD879D311AC5700A0C969E8905DE5A7@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Adam J. Richter'" <adam@yggdrasil.com>,
        acpi@phobos.fachschaften.tu-muenchen.de, linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: RE: [Acpi] [PATCH] linux-2.4.1-pre9/include/linux/acpi.h broke ac
	pid compilation
Date: Mon, 22 Jan 2001 09:51:18 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

acpi_get_rsdp_ptr is no longer used, so you can just remove its declaration.
I'm putting together another patch not so I'll include this fix.

Thanks -- Regards -- Andy

> -----Original Message-----
> From: Adam J. Richter [mailto:adam@yggdrasil.com]
> Sent: Sunday, January 21, 2001 12:23 AM
> To: acpi@phobos.fachschaften.tu-muenchen.de;
> linux-kernel@vger.kernel.org
> Cc: torvalds@transmeta.com
> Subject: [Acpi] [PATCH] linux-2.4.1-pre9/include/linux/acpi.h broke
> acpid compilation
> 
> 
> 	linux-2.4.1-pre9/include/linux/acpi.h contains declares the
> routine acpi_get_rsdp_ptr returning the kernel-only type 
> "u64", without
> bracketing the declaration in "#ifdef __KERNEL__...#endif".  
> Consequently,
> a user level program that attempts to include <linux/acpi.h>, such as
> acpid, gets a compilation error.  The following patch fix the problem
> by stretching an earlier "#ifdef __KERNEL__...#endif" area to cover
> the acpi_get_rsdp_ptr declaration.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
