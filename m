Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129428AbQK0Tfh>; Mon, 27 Nov 2000 14:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129455AbQK0Tf1>; Mon, 27 Nov 2000 14:35:27 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:53204 "EHLO
        delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
        id <S129428AbQK0TfV>; Mon, 27 Nov 2000 14:35:21 -0500
Date: Mon, 27 Nov 2000 20:04:51 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Mr. Big" <mrbig@sneaker.sch.bme.hu>
cc: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PROBLEM: crashing kernels
In-Reply-To: <Pine.LNX.3.96.1001127183433.9692E-100000@sneaker.sch.bme.hu>
Message-ID: <Pine.GSO.3.96.1001127193828.13774W-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2000, Mr. Big wrote:

> But maybe the /proc/interrupts could be usefull:
>            CPU0       CPU1       
>   0:     413111          0          XT-PIC  timer
>   1:        687          0          XT-PIC  keyboard
>   2:          0          0          XT-PIC  cascade
>   7:     751660          0          XT-PIC  eth1
>  10:    7377626          0          XT-PIC  eth0
>  11:     238981          0          XT-PIC  Mylex AcceleRAID 352, aic7xxx, aic7xxx
>  13:          1          0          XT-PIC  fpu
>  14:         10          0          XT-PIC  ide0
> NMI:          0
> ERR:          0

 Hmm, nothing special.  Getting this in the APIC mode would possibly be
more useful.  Isn't there anything that's sharing the IRQ with eth0 that's
unhandled?  An unhandled onboard device?  What IRQs are reported by
`/sbin/lspci -v'? 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
