Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269559AbTHOQjC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 12:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269523AbTHOQi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 12:38:58 -0400
Received: from yankee.rb.xcalibre.co.uk ([217.8.240.35]:34525 "EHLO
	yankee.rb.xcalibre.co.uk") by vger.kernel.org with ESMTP
	id S269559AbTHOQiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 12:38:06 -0400
Envelope-to: linux-kernel@vger.kernel.org
From: Alistair J Strachan <alistair@devzero.co.uk>
To: Clock <clock@twibright.com>, kenton.groombridge@us.army.mil
Subject: Re: nforce2 lockups
Date: Fri, 15 Aug 2003 17:38:08 +0100
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org
References: <df962fdf9006.df9006df962f@us.army.mil> <20030815171521.A683@beton.cybernet.src>
In-Reply-To: <20030815171521.A683@beton.cybernet.src>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200308151738.08965.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 August 2003 16:15, Clock wrote:
> On Fri, Aug 15, 2003 at 09:12:17PM +0900, kenton.groombridge@us.army.mil 
wrote:
> > Hi,
> >
> > I found your post looking for a solution to my lockups.  I bet if you do
> > a dmesg, you will find that your nforce2 chipset revision is 162.
>
> Yeah! Look:
>
> NFORCE2: chipset revision 162

[alistair] 05:37 PM [~] dmesg | grep "NFORCE2: chipset"
NFORCE2: chipset revision 162

A quick google for "NFORCE2: chipset revision" reveals no chipset revision 
dmesg except 162. It seems likely most manufactures are using the same 
revision.

I use APIC and ACPI on my EPoX 8RDA+, and I've never had any IO problems. So 
it seems unlikely that it is tied to a chipset revision.

[snip]
>
> It looks like the problem is in APIC. When you disable it, it vanishes.
> And, when you enable NMI watchdog, which is handled by APIC,
> it doesn't work - it couts up to 15 in /proc/interrupts and then stops!

I have not noticed any such APIC issues.

[alistair] 05:36 PM [~] uname -r
2.6.0-test3-mm2

[alistair] 05:37 PM [~] cat /proc/interrupts
           CPU0
  0:    4582940          XT-PIC  timer
  1:      22830    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  4:     340689    IO-APIC-edge  serial
  7:       4881    IO-APIC-edge  parport0
  8:          1    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 14:      12942    IO-APIC-edge  ide0
 15:         10    IO-APIC-edge  ide1
 16:          4   IO-APIC-level  bttv0
 19:     504114   IO-APIC-level  EMU10K1, nvidia
 20:      45043   IO-APIC-level  ohci-hcd
 21:          0   IO-APIC-level  ehci_hcd
 22:         82   IO-APIC-level  ohci-hcd
NMI:          0
LOC:    4582946
ERR:          0
MIS:          0

Sounds suspiciously like software to me.

Cheers,
Alistair.
