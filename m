Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267628AbTAHJiw>; Wed, 8 Jan 2003 04:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267782AbTAHJiw>; Wed, 8 Jan 2003 04:38:52 -0500
Received: from thanatos.clara.net ([195.8.69.60]:50450 "EHLO
	thanatos.clara.net") by vger.kernel.org with ESMTP
	id <S267628AbTAHJiv>; Wed, 8 Jan 2003 04:38:51 -0500
Date: Wed, 8 Jan 2003 09:47:28 +0000
From: Faye Pearson <faye@clara.net>
To: peter.holmes@fopet-esl.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ACPI] acpi_os_queue_for_execution()
Message-ID: <20030108094727.GA11860@clara.net>
References: <3E1AE2C9.13240.1114A3C@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E1AE2C9.13240.1114A3C@localhost>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.18 on an i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

peter.holmes@fopet-esl.com [peter.holmes@fopet-esl.com] wrote:
> As a relative newcomer to LINUX quite a lot of it is a foreign language,
> (no awful pun intended).  I've been around electronics and computers for
> quite a few years now.  So would you be so kind as to explain just what
> is "GPE_L00" and "DSDT".  And just how we remove the salient part?
> I have a new Acer Aspire 1304LC which I could cook an egg on.
> Windoze(2K & XP Pro) don't generate anything like so much warmth.

These terms have nothing to do with linux, they're ACPI things from
within the BIOS.  the GPE is a General Purpose Event I believe.  The
_L00 event seems to be an event which is generated if the machine gets
too hot - It may be called something different on a different
manufacturer's BIOS.

What you need to do is run an ACPI enabled kernel and dump the
/proc/acpi/dsdt to a file (cat /proc/acpi/dsdt > mydsdt.aml).  You can't
read this directly as it is in a compiled form.  You need to disassemble
it and you do that with the iasl assembler/disassembler you can get from
Intel's instantly available technology pages.
(http://www.intel.com/technology/iapc/acpi/downloads.htm)

Once you have it disassembled, try "compiling" it straight away and you
will probably find that there are errors and warnings.  Check the acpi
mailing list archives for details on how to fix these.

Once you have it working, compile it into the kernel - how to do this is
covered in the archives as well.  Booting with this kernel should make
your acpi work much better.  If it doesn't solve your heating problem
then if you put your disassembled and original dsdt on the web somewhere
and post a message asking for help, with links to these files on the
acpi list then you are likely to get some good assistance.

It is definitely worthwhile, my laptop now runs about 99% of the time
with no fan - showing it's much cooler.

The page with my efforts on for the Compaq Presario 2701EA is
http://dude.noc.clara.net/~faye/

Good luck.


Faye

-- 
Faye Pearson,
Covert Development
ClaraNET Ltd.       Tel 020 7903 3000

You don't move to Edina, you achieve Edina.
		-- Guindon
