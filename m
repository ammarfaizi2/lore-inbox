Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270618AbTGZXIb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 19:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270620AbTGZXIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 19:08:31 -0400
Received: from lidskialf.net ([62.3.233.115]:24001 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S270618AbTGZXIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 19:08:30 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Mika Liljeberg <mika.liljeberg@welho.com>
Subject: Re: 2.6.0-test1: irq18 nobody cared! on Intel D865PERL motherboard
Date: Sun, 27 Jul 2003 00:23:43 +0100
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <20030714131240.21759.qmail@linuxmail.org> <200307262313.08819.adq_dvb@lidskialf.net> <1059260505.1119.6.camel@hades>
In-Reply-To: <1059260505.1119.6.camel@hades>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307270023.43992.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 July 2003 00:01, Mika Liljeberg wrote:
> On Sun, 2003-07-27 at 01:13, Andrew de Quincey wrote:
> > Out of interest, do these boxes have an IO-APIC and are you using ACPI?
> > If so, can you tell me if the attached patch helps?
>
> Yes, yes, nope. I tried your patch but the SATA driver now hangs during
> boot waiting for an irq that never arrives.

This sounds very familiar. As I said, the patch fixes the IO-APIC so IRQ 
polarities and  mode is it is now setup as per ACPI... its obviously doing 
_something_ for you.

However, there is a second problem which I do not yet have a resolution for.

On my board, it manifests itself with PCI addon cards.. I never see any IRQs 
from them because the IO-APIC is configured (as per ACPI) for active high 
IRQs, yet the PCI standard is active low IRQs.

I am fairly certain that the IO-APIC is now configured correctly, and that the 
PCI routing is correct, because Windows XP sets everything up in exactly the 
same way, and everything works fine under it. 

There is something else that is not being done by linux. I'd assumed this was 
an nforce2-specific issue, but your results hint that it may be larger than 
this. 

