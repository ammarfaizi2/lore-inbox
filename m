Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265174AbSLQSBW>; Tue, 17 Dec 2002 13:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265230AbSLQSBW>; Tue, 17 Dec 2002 13:01:22 -0500
Received: from poup.poupinou.org ([195.101.94.96]:3079 "EHLO poup.poupinou.org")
	by vger.kernel.org with ESMTP id <S265174AbSLQSBV>;
	Tue, 17 Dec 2002 13:01:21 -0500
Date: Tue, 17 Dec 2002 19:06:07 +0100
To: Simon Oosthoek <simon@margo.student.utwente.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q: i845MP/P4-M laptop support? (specific problems listed)
Message-ID: <20021217180607.GA1012@poup.poupinou.org>
References: <20021216100610.GA16816@margo.student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216100610.GA16816@margo.student.utwente.nl>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2002 at 11:06:10AM +0100, Simon Oosthoek wrote:
> Hi all
> 
> I've been following kernel-traffic and sometimes the web-archives in search
> for some clues about support for my laptop (jewel jade 8060, specs(in dutch):
> URL:http://www.jewelnotebooks.nl/index.php?page=jade-8060)

It sound like to be actually the same as a Toshiba Satellite for me.
Interresting.  FYI, this model is made by Compal <http://www.compal.com>
which is the actual manufacturer.

> 
> I've noticed some problems and I've seen some proposals for patches and
> fixes, but I don't have a clear picture of which is fixed and by which
> patch...
> 
> The problems I have seen:
> - apm doesn't seem to work 
>   output: 
>   APM BIOS 1.2 (kernel driver 1.16)
>   AC on-line, no system battery

APM do not work with the Satellite too.  So, yes, it is very likely to be
the exact same model...

>   
>   Q: will the ACPI patches help with this?

Yes and no.  You will have to make a (little) workaround in order to get ACPI
working, due to a bug in the BIOS.

> 
> - the -ac2 patch wasn't able to boot at all (no messages), but I haven't
> tried it more than once... the intel speedstep feature would be nice to have
> though...

You could have that with ACPI.  Alternatively, you can try cpufreq.

> 
> - resource collision on PCI 00:1f.1?
>   bootmessages: PCI: Device 00:1f.1 not available because of resource collisions
> 
> - missing driver for smartmedia slot

In fact, the smartmedia slot is available as a USB device..
Just compile with SCSI support.  Under the USB menu, you have a
'USB Mass Storage support' entry.  You should then have a 
'Microtech CompactFlash/SmartMedia support'


> from "lspci -v":
> 02:06.0 System peripheral: Toshiba America Info Systems: Unknown device 0804
> (rev 02)
>         Subsystem: COMPAL Electronics Inc: Unknown device 0012
>         Flags: slow devsel, IRQ 11
>         Memory at e0000c00 (32-bit, non-prefetchable) [disabled] [size=32]
>         Capabilities: <available only to root>

This is the Firewire link.  You can try IEEE 1394, the correct driver
should be OHCI-1394.  Since I have no HW to play with that, I can not
promise anything..


A final word: if you want ACPI for this one, you should go to
http://sf.net/projects/acpi

Try the latest patch.  Alas, if your model is buggy in the BIOS, (and
I know already that it is the case, actually) you should
ask for help in acpi mailing list at acpi-devel (at) lists.sourceforge.net
or ask me privately (but at ducrot (at) poupinou.org with a subject
containing ACPI please).

Cheers,

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page
