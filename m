Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129072AbRBGMcv>; Wed, 7 Feb 2001 07:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129027AbRBGMcb>; Wed, 7 Feb 2001 07:32:31 -0500
Received: from [194.213.32.137] ([194.213.32.137]:4868 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129078AbRBGMb2>;
	Wed, 7 Feb 2001 07:31:28 -0500
Message-ID: <20010207114505.A122@bug.ucw.cz>
Date: Wed, 7 Feb 2001 11:45:05 +0100
From: Pavel Machek <pavel@suse.cz>
To: Juraj Bednar <juraj@bednar.sk>, acpi@phobos.fachschaften.tu-muenchen.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: acpi breaks async interface
In-Reply-To: <20010206004642.A24599@rak.isternet.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010206004642.A24599@rak.isternet.sk>; from Juraj Bednar on Tue, Feb 06, 2001 at 12:46:42AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  I just found a strange thing in 2.4.1 (don't know, if the same
> occured in 2.4.0) and 2.4.1-ac3. When I enable ACPI, my serial
> port starts to drop some characters. When making ppp over this
> and doing ping, it causes great packet losts. If I turn ACPI in
> this configuration off, it works with no problems. I tried to
> switch serial port IRQ to other one (was 4, switched to 3 and
> tested) and it didn't help. Maybe something's broken.
> 
>  ACPI related boot messages:
> 
> Feb  4 23:21:58 idoru kernel: ACPI: Core Subsystem version [20010125]
> Feb  4 23:21:58 idoru kernel: ACPI: Subsystem enabled
> Feb  4 23:21:58 idoru kernel: ACPI: System firmware supports: C2 C3
> Feb  4 23:21:58 idoru kernel: ACPI: System firmware supports: S0 S1 S4 S5
> 
> [root@idoru log]# cat /proc/interrupts 
>            CPU0       
>   0:      57278          XT-PIC  timer
>   1:       2658          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   4:      49530          XT-PIC  serial
>   5:          1          XT-PIC  soundblaster
>  10:         15          XT-PIC  aha152x
>  11:         60          XT-PIC  eth0
>  12:      27772          XT-PIC  PS/2 Mouse
>  14:     213118          XT-PIC  ide0
>  15:       3298          XT-PIC  ide1
> NMI:          0 
> LOC:          0 
> ERR:          0

ACPI slows down CPU quite a lot. Maybe cpu is so slow it can no longer
handle serial in time?

Try running 

while(1);

program while doing serial transfers.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
