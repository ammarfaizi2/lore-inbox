Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263164AbVFXSx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263164AbVFXSx6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 14:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263168AbVFXSx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 14:53:58 -0400
Received: from mail.tyan.com ([66.122.195.4]:24841 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S263176AbVFXSxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 14:53:05 -0400
Message-ID: <3174569B9743D511922F00A0C94314230AF97123@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@suse.de>
Cc: Peter Buckingham <peter@pantasys.com>, linux-kernel@vger.kernel.org
Subject: RE: 2.6.12 with dual way dual core ck804 MB
Date: Fri, 24 Jun 2005 11:56:23 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

Thanks for the patch, I tried that with my LinuxBIOS + 8way dual core.

It works well. 

I'm using that with 2.6.12, because 2.6.11 has problem with nvidia
chipset....

~ # cat /proc/interrupts 
           CPU0       CPU1       CPU2       CPU3       CPU4       CPU5
CPU6       CPU7       CPU8       CPU9       CPU10       CPU11       CPU12
CPU13       CPU14       CPU15       
  0:     378977          0          0          0          0          0
0          0          0          0          0          0          0
0          0          0    IO-APIC-edge  timer
  2:          0          0          0          0          0          0
0          0          0          0          0          0          0
0          0          0          XT-PIC  cascade
  4:       1284          0          0          0          0          0
0          0          0          0          0         0          0
0          0          0    IO-APIC-edge  serial
  8:          0          0          0          0          0          0
0          0          0          0          0          0          0
0          0          0    IO-APIC-edge  rtc
 20:          0          0          0          0          0          0
0          0          0          0          0          0          0
0          0          0   IO-APIC-level  ehci_hcd:usb1
 21:          0          0          0          0          0          0
0          0          0          0          0          0          0
0          0          0   IO-APIC-level  ohci_hcd:usb2
 22:          0          0          0          0          0          0
0          0          0          0          0          0          0
0          0          0   IO-APIC-level  libata
 23:          0          0          0          0          0          0
0          0          0          0          0          0          0
0          0          0   IO-APIC-level  libata
NMI:        781        661         48         51         51         51
51         51         51         51         53         52         53
53         53         53 
LOC:     378822     378680     379254     379214     379172     379131
379088     379046     379004     378962     378921     378877     378834
378791     378748     378705 
ERR:         55

and all int come to first cpu now.

the problem is the 2.6.12 timing problem with nvidia chipset is still there,
i hope that i have time to dubug it for your next week.

YH

> -----Original Message-----
> From: Andi Kleen [mailto:ak@suse.de] 
> Sent: Wednesday, June 22, 2005 5:13 PM
> To: YhLu
> Cc: Andi Kleen; Peter Buckingham; linux-kernel@vger.kernel.org
> Subject: Re: 2.6.12 with dual way dual core ck804 MB
> 
> On Wed, Jun 22, 2005 at 05:07:44PM -0700, YhLu wrote:
> > actually with LinuxBIOS I can boot into 8 way dual core system.
> > 
> > But it will randomly hang. acutally when using cat /proc/interrupts.
> 
> Because it needs physical addressing, not logical like it is 
> used right now.
> That it works at all is surprising.
> 
> -Andi
> 
