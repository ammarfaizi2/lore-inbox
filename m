Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272308AbTGYUho (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 16:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272309AbTGYUho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 16:37:44 -0400
Received: from fmr05.intel.com ([134.134.136.6]:44797 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S272308AbTGYUhi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 16:37:38 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH] Linux 2.6-pre-mm2 Fix crash on boot on ASUS L3800C if enabing APIC => add this machine to DMI black list
Date: Fri, 25 Jul 2003 13:52:44 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A847E97080@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Linux 2.6-pre-mm2 Fix crash on boot on ASUS L3800C if enabing APIC => add this machine to DMI black list
Thread-Index: AcNPJYUFYJ5tPLMeS4W5jNvNlLTLTADyLZeA
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Mikael Pettersson" <mikpe@csd.uu.se>, <akpm@osdl.org>,
       <eric.valette@free.fr>, <sziwan@hell.org.pl>
Cc: <acpi-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Jul 2003 20:52:44.0620 (UTC) FILETIME=[B274D0C0:01C352EE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Mikael Pettersson [mailto:mikpe@csd.uu.se] 
> On Sun, 20 Jul 2003 21:48:24 +0200, Eric Valette wrote:
> >The following patch integrated in 2.5.74,
> >
> ><http://lists.insecure.org/lists/linux-kernel/2003/Jun/5840.html>

> At least two P4 laptops are known to require the 2.5.74 patch, and
> they do work with the local APIC.
> 
> While I don't dispute your machine has some problem, please
> do the following first before we completely blacklist it:
> - ensure you have the latest BIOS (ftp.asuscom.de has the ones for
>   their desktop mainboards, presumably the laptop BIOSen are 
> also there)
> - in what way is ACPI mandatory? does it fail to boot, or does it
>   just lose some specific feature? If you just want suspend support,
>   try APM if the machine has it
> 
> A question for the ACPI people:
> - Does the Linux kernel ACPI code ever transfer control to BIOS,
>   explicitly or implicitly via SMIs triggered by the interpreter?
>   If you do transfer control, do you disable interrupts and/or
>   the interrupt controllers before transferring control?
>   Entering BIOS with the local APIC live, in particular the timer,
>   is a known hang-generator with APM.

Yes, some OEMs (IBM, for one. I'm sure there are more) enter SMM when
executing control methods. The interpreter is just blithely going along
and writing values to mem and io ports -- it doesn't know it just
invoked SMM. Nothing is disabled.

BTW I'm getting a bunch of other reports starting with 2.5.74 (see
"linux laptop keyboard problem since 2.5.74"). 

So let me get this straight -- because 2 machines require this patch,
you want all the OTHER machines to go on the blacklist? Shouldn't the 2
machines get special-cased?

All these machines work under Windows, so there has to be a solution
that enables everyone to work.

Regards -- Andy
