Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbUKWWbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbUKWWbI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 17:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbUKWWav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 17:30:51 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:51388 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S261574AbUKWW0W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 17:26:22 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-bk7, back to an irq 12 "nobody cared!"
User-Agent: KMail/1.7
References: <200411230014.15354.gene.heskett@verizon.net> <20041123113957.D14339@build.pdx.osdl.net> <200411231530.56258.gene.heskett@verizon.net>
In-Reply-To: <200411231530.56258.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Disposition: inline
Date: Tue, 23 Nov 2004 17:26:21 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411231726.21300.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.205.10.220] at Tue, 23 Nov 2004 16:26:21 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 November 2004 15:30, Gene Heskett wrote:

Here I go again, replying to my own post, with new info

>On Tuesday 23 November 2004 14:39, Chris Wright wrote:
>>* Zwane Mwaikambo (zwane@linuxpower.ca) wrote:
>>> On Mon, 22 Nov 2004, Andrew Morton wrote:
>>> > Gene Heskett <gene.heskett@verizon.net> wrote:
>>> > > Just built bk7 after running the bk4-kjt1 version for a
>>> > > cpouple of days, and noticed this in /var/log/dmesg:
>>
>>Try current, should be fixed.
>>
>>thanks,
>>-chris
>
>Current, as in bk8?  Or have the janitors a new one? In which case a
>url please. :-)

Ok, I've built and rebooted to 2.6.10-rc2-bk8, but the magic 
invocation on the kernel command line doesn't seem to have any 
effect.  THat was to append the string

acpi_skip_timer_override

to that line in grub.conf.

A cat of proc/interrupts shows many shared irq's again.
root@coyote linux-2.6.10-rc2-bk8]# cat /proc/interrupts
           CPU0
  0:     247857          XT-PIC  timer
  1:        862          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  3:         20          XT-PIC  serial
  4:        993          XT-PIC  serial
  5:       3238          XT-PIC  ehci_hcd, radeon@pci:0000:02:00.0
  7:        226          XT-PIC  parport0
  8:          2          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 11:      22798          XT-PIC  ohci_hcd, eth0, Bt87x audio
 12:        806          XT-PIC  ohci_hcd, NVidia nForce2
 14:      10864          XT-PIC  ide0
 15:       2574          XT-PIC  ide1
NMI:          0
LOC:     247790
ERR:         44

And, while the rest of the counters are incrementing as expected, the 
ERR: seems to be stuck at 44.  I assume thats good that its not 
incrementing (now) but 2.6.10-rc2 has it as a 0 for extended periods 
of time.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.29% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
