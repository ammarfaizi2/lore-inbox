Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132105AbQKWOXs>; Thu, 23 Nov 2000 09:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132669AbQKWOXj>; Thu, 23 Nov 2000 09:23:39 -0500
Received: from omecihuatl.rz.Uni-Osnabrueck.DE ([131.173.17.35]:27397 "EHLO
        omecihuatl.rz.Uni-Osnabrueck.DE") by vger.kernel.org with ESMTP
        id <S132105AbQKWOX3>; Thu, 23 Nov 2000 09:23:29 -0500
Date: Thu, 23 Nov 2000 14:52:23 +0100 (MET)
From: ARND BERGMANN <std7652@et.FH-Osnabrueck.DE>
To: linux-kernel@vger.kernel.org
Subject: test11: lockup when reading /proc/ide/hde/identify
Message-ID: <Pine.GSO.4.21.0011231433290.2260-100000@gamma10>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I think I found a bug in the IDE subsystem. When I do 'cat
/proc/ide/hde/identify', the system locks up completely, not
even Alt+RysRq+B helps. Everything else under /proc/ide works.
hdparm can cause the same symptoms, but I have not checked
when exactly it does so.

I have an Asus A7V mainboard with VIA 82C686A as first IDE
controller and an onboard Promise PDC20265 as second IDE
controller.
Both have a Fujitsu MPF3204AT as their primary master drive,
but the problem occurs only on the Promise adapter.

I have tried kernel 2.4.0-test11-pre6, test11-ac2 and 
ide.2.4.0-t11.1120, all with the same result, but I did not
try any older kernels, because I installed the machine
just two days ago.

Arnd <><

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
