Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130864AbQLTCdD>; Tue, 19 Dec 2000 21:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131017AbQLTCcy>; Tue, 19 Dec 2000 21:32:54 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:16144 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S130864AbQLTCch>; Tue, 19 Dec 2000 21:32:37 -0500
Message-ID: <4148FEAAD879D311AC5700A0C969E8905DE54A@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Adam J. Richter'" <adam@yggdrasil.com>, acme@conectiva.com.br,
        acpi@phobos.fachschaften.tu-muenchen.de
Cc: linux-kernel@vger.kernel.org
Subject: RE: [Acpi] 2.4.0-test13pre3 acpi circular dependency
Date: Tue, 19 Dec 2000 18:00:15 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm thinking arch/i386/kernel/acpi.c should just go away, yes?

Its purpose is probably better served by an ifdef, like you mentioned.

Regards -- Andy


> -----Original Message-----
> From: Adam J. Richter [mailto:adam@yggdrasil.com]
> Sent: Tuesday, December 19, 2000 5:01 PM
> To: acme@conectiva.com.br; acpi@phobos.fachschaften.tu-muenchen.de
> Cc: linux-kernel@vger.kernel.org
> Subject: [Acpi] 2.4.0-test13pre3 acpi circular dependency
> 
> 
> 	Although the stock linux-2.4.0-test13pre3 does not allow
> one to build the acpi interpreter as a loadable module, I had
> tweaked the Makefiles in previous kernels to do this (the supporting
> code is there and it seemed to work, at least for shutting off the
> power after a shutdown).  Unfortunately, in 2.4.0-test13pre3, this
> is no harder to do, because there is a circular dependency:
> 
> drivers/acpi/ references acpi_get_rsdp_ptr in arch/i386/kernel/acpi.c,
> 				and
> arch/i386/kernel/acpi.c references acp_find_root_pointer in 
> drivers/acpi/.
> 
> 
> 	I would like to recommend that the contents of
> arch/i{386,a64}/kernel/acpi.c be merged back somewhere in 
> drivers/acpi/,
> and just selected with Makefile options, ifdefs, or perhaps runtime
> options (if the ia64 code is potentionally useable to an i386 kernel
> that find itself running on an ia64 CPU, which will probably 
> be the case
> with most Linux distributions initially installed on ia64 hardware).
> 
> 	If need be, I would be willing to at least write a quick and
> dirty #ifdef-based version of this proposed change.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
