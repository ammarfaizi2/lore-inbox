Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277431AbRJVB0s>; Sun, 21 Oct 2001 21:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277409AbRJVB0i>; Sun, 21 Oct 2001 21:26:38 -0400
Received: from zero.tech9.net ([209.61.188.187]:2564 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S277440AbRJVB0X>;
	Sun, 21 Oct 2001 21:26:23 -0400
Subject: Re: Linux 2.4.12-ac5
From: Robert Love <rml@tech9.net>
To: "Udo A. Steinberg" <reality@delusion.de>
Cc: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
        laughing@shared-source.org
In-Reply-To: <3BD3743C.CF87EE89@delusion.de>
In-Reply-To: <Pine.LNX.4.30.0110220249230.17514-100000@Appserv.suse.de> 
	<3BD3743C.CF87EE89@delusion.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.18.15.19 (Preview Release)
Date: 21 Oct 2001 21:26:58 -0400
Message-Id: <1003714021.1014.144.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-10-21 at 21:19, Udo A. Steinberg wrote:
> Dave Jones wrote:
> > 
> > Odd, that part builds fine here. The missing declaration you get is
> > declared in fixmap.h, which is included from pgalloc.h. Untar a fresh tree,
> > and reapply the patch.
>
> Just in order to ensure I'm not insane, could you try building with the
> following .config file?

You aren't crazy, it doesn't build here either.  The problem is that
fixmap.h only includes those defines if CONFIG_IO_APIC is defined. 
Well, I don't have use IO_APIC (I am UP) but I do define
CONFIG_X86_APIC.  So it does not compile.

So, the problem is that acpitable.c assumes you have both CONFIG_IO_APIC
and CONFIG_X86_APIC declared.  It shouldn't.  Even more important, why
is my system compiling acpitable.c now?  I don't compile anything to do
with ACPI.  What needs access to the ACPI tables via Mini-ACPI, now?

	Robert Love

