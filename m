Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269602AbTHGQy2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 12:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270325AbTHGQy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 12:54:28 -0400
Received: from main.gmane.org ([80.91.224.249]:12483 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S269602AbTHGQy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 12:54:26 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: DMA timeouts on SIS IDE
Date: Thu, 07 Aug 2003 18:48:16 +0200
Message-ID: <yw1xptjhs9bj.fsf@users.sourceforge.net>
References: <3F281C06.70707@inet6.fr> <yw1xbrvbgdx5.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:U6k7yTe2aGlILs06u4jrrt4z20g=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mru@users.sourceforge.net (M�ns Rullg�rd) writes:

>> the lspci output you previously sent confirmed that the SiS IDE driver
>> does set the UDMA timings correctly. Given this is out of the suspects
>> list, I'd advise to :
>>
>> - test the hardware (uneasy on a notebook, 2.5" IDE drives aren't as
>> common as 3.5" ones)
>
> As you say, testing could be tricky.  However, the machine is only
> about one month old, so it shouldn't be dying already.
>
>> - try latest ACPI on sourceforge and enable ACPI in the BIOS if not
>> already done (seems to have helped once :
>> http://marc.theaimsgroup.com/?l=linux-kernel&m=104212864518052&w=4)
>
> patch tells me those are already applied to 2.6.0-test2.  I tried
> booting with pci=noacpi, just in case, but the problem remains.  I
> can't find any BIOS settings relating to ACPI.

The issue is still unresolved.

I noticed that sometimes I also get this in the kernel log:

hda: dma_timer_expiry: dma status == 0x21
hda: DMA timeout error
hda: dma timeout error: status=0xd0 { Busy }

hda: DMA disabled
ide0: reset: success
Loosing too many ticks!
TSC cannot be used as a timesource. (Are you running with SpeedStep?)
Falling back to a sane timesource.

I am not using SpeedStep, so that message must be triggered by the IDE
errors.  The errors only happen when writing very large (hundreds of
megabytes) amounts of data at rate above a few megabytes per second.
It's never happened when just doing normal things like compiling
stuff.

-- 
M�ns Rullg�rd
mru@users.sf.net

