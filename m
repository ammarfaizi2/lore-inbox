Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269106AbUJVX0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269106AbUJVX0S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 19:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268379AbUJVXZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 19:25:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:6305 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269227AbUJVXWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 19:22:55 -0400
Date: Fri, 22 Oct 2004 16:26:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-mm1: NForce3 problem (IRQ sharing issue?)
Message-Id: <20041022162656.2f9ca653.akpm@osdl.org>
In-Reply-To: <200410222354.44563.rjw@sisk.pl>
References: <200410222354.44563.rjw@sisk.pl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> Hi,
> 
> I have a problem with 2.6.9-mm1 on an AMD64 NForce3-based box.  Namely, after 
> some time in X, USB suddenly stops working and sound goes off simultaneously 
> (it's quite annoying, as I use a USB mouse ;-)).  It is 100% reproducible and 
> it may be related to the sharing of IRQ 5:
> 
> rafael@albercik:~> cat /proc/interrupts
>            CPU0
>   0:    3499292          XT-PIC  timer
>   1:       7135          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>   5:       6945          XT-PIC  NVidia nForce3, ohci_hcd
>   8:          0          XT-PIC  rtc
>   9:       1416          XT-PIC  acpi, yenta
>  10:          2          XT-PIC  ehci_hcd
>  11:      37266          XT-PIC  SysKonnect SK-98xx, yenta, ohci1394, ohci_hcd
>  12:      13781          XT-PIC  i8042
>  14:         16          XT-PIC  ide0
>  15:      23601          XT-PIC  ide1
> NMI:          0
> LOC:    3498657
> ERR:          1
> MIS:          0
> 
> (NVidia nForce3 is a sound chip, snd_intel8x0).  After it happens I can't 
> reboot the box cleanly (the ohci-hcd driver cannot be reloaded) and it does 
> not leave any traces in the log.
> 

Beats me.  Does the interrupt count stop increasing?
