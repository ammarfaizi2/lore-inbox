Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbVFWAGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVFWAGZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 20:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVFWAEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 20:04:36 -0400
Received: from mail.tyan.com ([66.122.195.4]:48907 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S261839AbVFWAEQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 20:04:16 -0400
Message-ID: <3174569B9743D511922F00A0C94314230AF96FB1@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@suse.de>
Cc: Peter Buckingham <peter@pantasys.com>, linux-kernel@vger.kernel.org
Subject: RE: 2.6.12 with dual way dual core ck804 MB
Date: Wed, 22 Jun 2005 17:07:44 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

actually with LinuxBIOS I can boot into 8 way dual core system.

But it will randomly hang. acutally when using 
cat /proc/interrupts.

           CPU0       CPU1       CPU2       CPU3       CPU4       CPU5
CPU6       CPU7       CPU8       CPU9       CPU10       CPU11       CPU12
CPU13       CPU14       CPU15       
  0:        409          0          0          0          0          0
0          0          0          0        229      37399          0
0          0          0    IO-APIC-edge  timer
  2:          0          0          0          0          0          0
0          0          0          0          0          0          0
0          0          0          XT-PIC  cascade
  4:          0          0          0          0          0          0
0          0          0          0          0       4915          0
0          0          0    IO-APIC-edge  serial
  8:          0          0          0          0          0          0
0          0          0          0          0          0          0
0          0          0    IO-APIC-edge  rtc
 14:          0          0          0          0          0          0
0          0          0          0          0         10          0
0          0          0    IO-APIC-edge  ide0
 19:          0          0          0          0          0          0
0          0          0          0          0          0          0
0          0          0   IO-APIC-level  ohci1394
 20:          0          0          0          0          0          0
0          0          0          0          0          0          0
0          0          0   IO-APIC-level  libata
 21:          0          0          0          0          0          0
0          0          0          0          0          0          0
0          0          0   IO-APIC-level  libata
 22:          0          0          0          0          0          0
0          0          0          0          0          0          0
0          0          0   IO-APIC-level  ohci_hcd
 23:          0          0          0          0          0          0
0          0          0          0          0          0          0
0          0          0   IO-APIC-level  ehci_hcd
NMI:          1          0          0          0          0          0
0          0          0          0          0          1          0
0          0          0 
LOC:      37688      37965      37965      37965      37965      37965
37965      37965      37965      37965      37965      37446      37965
37965      37965      37966 
ERR:        447
MIS:          0

I wonder why all int is direct to cpu8.

YH
 

> -----Original Message-----
> From: Andi Kleen [mailto:ak@suse.de] 
> Sent: Wednesday, June 22, 2005 4:37 PM
> To: YhLu
> Cc: Peter Buckingham; Andi Kleen; linux-kernel@vger.kernel.org
> Subject: Re: 2.6.12 with dual way dual core ck804 MB
> 
> On Wed, Jun 22, 2005 at 04:37:37PM -0700, YhLu wrote:
> > andi,
> > 
> > do you mean the apic id lifting for opteron?
> 
> Yes, with local APIC numbers > 8 physical mode needs to be 
> used because logical mode only supports 8.
> 
> -Andi
> 
