Return-Path: <linux-kernel-owner+willy=40w.ods.org-S276712AbUKAT0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S276712AbUKAT0V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 14:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S291259AbUKATZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 14:25:57 -0500
Received: from hentges.net ([81.169.178.128]:4536 "EHLO
	h6563.serverkompetenz.net") by vger.kernel.org with ESMTP
	id S264957AbUKATXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 14:23:01 -0500
Subject: Re: [2.6.10-rc1-mm2] keyboard / synaptics not working
From: Matthias Hentges <mailinglisten@hentges.net>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200410312342.01850.dtor_core@ameritech.net>
References: <200410311903.06927@zodiac.zodiac.dnsalias.org>
	 <200410312131.20088.dtor_core@ameritech.net>
	 <1099277136.11089.1.camel@mhcln03>
	 <200410312342.01850.dtor_core@ameritech.net>
Content-Type: multipart/mixed; boundary="=-FmD8whWlxrXPAMjS2C7c"
Date: Mon, 01 Nov 2004 20:22:46 +0100
Message-Id: <1099336966.4174.6.camel@mhcln03>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FmD8whWlxrXPAMjS2C7c
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Am Sonntag, den 31.10.2004, 23:42 -0500 schrieb Dmitry Torokhov:
> On Sunday 31 October 2004 09:45 pm, Matthias Hentges wrote:
> > Am Mo, den 01.11.2004 schrieb Dmitry Torokhov um 3:31:
> > 
> > [...]
> > 
> > > Can I get a binary version of it (straight out of /proc/acpi/dsdt) please?
> > > The one you send was converted into C source while I need ASL.
> > > 
> > Sure, it's attached.
> 
> Hmm, i8042 already recognizes both PNP IDs from your DSDT:

[...]

> I wonder what is going on... I see there was big ACPI update in -mm2,
> could you try reverting bk-acpi.patch.

I tried that, but w/o bk-acpi.patch, the kernel won't compile, sorry.
I don't have the skills to work around that. I've attached the error
message from "make bzImage".

> Btw, you said you are using 2.6.10-rc1 - is there -mm suffix missing?

I just forgot to write it  :) I was in fact using 2.6.10-rc1-mm2.
BTW: I didn't check the touchpad as i had an USB mouse attached (which
worked
w/o problems). The keyboard however, was completely dead (not even
CAPSLOCK worked)

> Linus's tree does not have i8042 ACPI enumeration patch yet so 
> i8042.noacpi does not have any effect and should not even be recognized
> by the kernel.

Sorry for the confusion :)
-- 
Matthias Hentges 
Cologne / Germany

[www.hentges.net] -> PGP welcome, HTML tolerated
ICQ: 97 26 97 4   -> No files, no URL's

My OS: Debian SID. Geek by Nature, Linux by Choice

--=-FmD8whWlxrXPAMjS2C7c
Content-Disposition: attachment; filename=compile-error.txt
Content-Type: text/plain; name=compile-error.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit

power/pm.c:234)         
drivers/acpi/processor.c: In Funktion »acpi_processor_start«:
drivers/acpi/processor.c:2328: error: `acpi_processor_notify' undeclared (first use in this function)   
drivers/acpi/processor.c:2328: error: (Each undeclared identifier is reported only once                 
drivers/acpi/processor.c:2328: error: for each function it appears in.)
drivers/acpi/processor.c: Auf höchster Ebene:
drivers/acpi/processor.c:2362: error: `acpi_processor_notify' used prior to declaration                 
drivers/acpi/processor.c: In Funktion »acpi_processor_add«:
drivers/acpi/processor.c:2398: Warnung: unused variable `result'
drivers/acpi/processor.c:2399: Warnung: unused variable `status'
drivers/acpi/processor.c:2401: Warnung: unused variable `i'
drivers/acpi/processor.c: Auf höchster Ebene:
drivers/acpi/processor.c:2303: Warnung: `acpi_processor_start' defined but not used                     
make[2]: *** [drivers/acpi/processor.o] Fehler 1
make[1]: *** [drivers/acpi] Fehler 2
make: *** [drivers] Fehler 2

--=-FmD8whWlxrXPAMjS2C7c--

