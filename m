Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130339AbQJ2TOI>; Sun, 29 Oct 2000 14:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131606AbQJ2TN6>; Sun, 29 Oct 2000 14:13:58 -0500
Received: from sigtrap.GUUG.DE ([134.95.80.189]:59750 "EHLO sigtrap.guug.de")
	by vger.kernel.org with ESMTP id <S130339AbQJ2TNn>;
	Sun, 29 Oct 2000 14:13:43 -0500
Date: Sun, 29 Oct 2000 20:11:15 +0100 (CET)
From: Winfried Truemper <winni@xpilot.org>
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
cc: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test10pre5: still IDE lockups on HPT366 controller.
In-Reply-To: <Pine.LNX.4.10.10010242047010.31835-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.21.0010291807580.3243-100000@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 24 Oct 2000, Mark Hahn wrote:

> > APIC error on CPU1 00(02)       or 02(02)  or 00(08)  or 00(04)
> 
> BP6 bugs, not linux's, and especially not ide's fault.  you have to
> do the usual BP6 voodoo: bios update, extra fans, big PS, higher voltage.

On friday I bought a power supply with 431 watts, updated the BIOS to the
latest versions, put a fan on the BX chip like described on www.bp6.com,
screwed two high performance fans on the top of the non-overclocked
celerons (what a waste :) ) and set the voltage to 2.1 volts (tested 2.0,
too). No improvement in stability: after a few seconds bonnie crashes the
machine when used on hde4 or hdg4. Today I replaced the cables to enforce
UDMA 33 instead of UDMA 66 on hde and hdg. No problems so far. I can start
20 parallel bonnie's on the disks without any errors. This is an
acceptable fix for me, because the raid5-array would be limited by UDMA33
on hda and hdc anyways.

Regarding the APIC messages... I see no rule when they occur. I believe
they were gone when using the better power supply, but perhaps I just
didn't tested long enough before I returned this expensive box... 


Regards
-Winfried

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
