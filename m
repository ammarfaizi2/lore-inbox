Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270272AbTHHIYM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 04:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270448AbTHHIYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 04:24:12 -0400
Received: from web40607.mail.yahoo.com ([66.218.78.144]:11322 "HELO
	web40607.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270272AbTHHIYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 04:24:10 -0400
Message-ID: <20030808082409.29780.qmail@web40607.mail.yahoo.com>
Date: Fri, 8 Aug 2003 09:24:09 +0100 (BST)
From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: Loading Pentium III microcode under Linux - catch 22!
To: Tigran Aivazian <tigran@veritas.com>
Cc: Chris Rankin <rankincj@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0308071651340.12315-100000@einstein31.homenet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Tigran Aivazian <tigran@veritas.com> wrote:
> Alternatively, yes, he can do it from within initrd.
> Hope that is early 
> enough for him.

Hi,

Yes, I think I'll go the initrd route. However,
hammering on the machine last night reproduced the
malfunction regardless of whether the microcode was
loaded or not!

(Addressing list in general:)

This board (Supermicro PIIIDME, i840 chipset) has been
stable for almost 3 years, since between 2.4.0-pre6
and 2.4.0-pre9 IIRC. All recent hangs and lock-ups
have been attributable to the IO subsystem in 2.4.20,
and it just ran 2.4.21 for 3 solid weeks. The only
thing that has really changed recently is the weather,
but the lm_sensors package (2.6.5) reports that
everything is fine.

Booting with "acpi=off" has so far prevented the
kernel from hanging just after the "Freeing unused
kernel memory" message. However, the kernel still hung
later: the first time was when reading lm_sensors
after one CPU had reached the magic BIOS setting of 55
degrees C under high load. This hang took out the
keyboard, mouse and serial console straight away, but
left the ethernet interface running for a few minutes.
The second hang was more spontaneous, and killed the
box outright.

Do ATX power supplies have temperature sensors built
into them? I have just upgraded my PSU from 300W to a
brand new 400W one, so doubt that it's faulty. Could
the power supply be triggering a temperature-related
ACPI event? I seem to recall the boot-log mentioning
assorted S and C events being supported. (Can't
remember which ones exactly: S0 and S3?)

And I have already run memtest for 2 hours without
problems.

Cheers,
Chris


________________________________________________________________________
Want to chat instantly with your online friends?  Get the FREE Yahoo!
Messenger http://uk.messenger.yahoo.com/
