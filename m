Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288255AbSBDC7j>; Sun, 3 Feb 2002 21:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288256AbSBDC73>; Sun, 3 Feb 2002 21:59:29 -0500
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:58895
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S288255AbSBDC7Z>; Sun, 3 Feb 2002 21:59:25 -0500
Message-Id: <5.1.0.14.2.20020203203302.00abcec8@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 03 Feb 2002 21:55:00 -0500
To: David Woodhouse <dwmw2@infradead.org>, Thomas Hood <jdthood@mail.com>
From: Stevie O <stevie@qrpff.net>
Subject: APM and APIC -- multiple batteries (was: apm.c and multiple
  battery slots)
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <12638.1012737679@redhat.com>
In-Reply-To: <1012705104.774.4.camel@thanatos>
 <1012705104.774.4.camel@thanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:01 PM 2/3/2002 +0000, David Woodhouse wrote:
>Please don't add an APM-specific interface for batteries. Look at the other
>code which talks to batteries - the ACPI code, SMBus and numerous other
>drivers for embedded systems - and design an interface to userspace which
>can be used by all of them.
>
>Preferably not in /proc.

Well, the only other interface I know of is device files, and from what 
I've seen, that seems to be a place where we autoload drivers when needed...

Besides, pretty much everything else in /proc is for transmitting (normally 
unchangeable, except for the sysctls) information from kernel to userspace. 
Why not /proc?

--

Now that you mention it, yes, I agree that an APM-specific interface for 
batteries would make code reuse harder (needing stuff for both APM and ACPI 
stuff). So we could have /proc/batteries/ maybe?

How does the ACPI stuff handle this? *Does* the ACPI stuff handle this 
(i.e. multiple batteries)?
If so:
   Is it a generic interface?
     If so, we should let APM use it too.
     If not, could we perhaps change it to one?
If not:
   I'm ready for suggestions about my original idea :)


--
Stevie-O

Real programmers use COPY CON PROGRAM.EXE

