Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130238AbRBZObG>; Mon, 26 Feb 2001 09:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130227AbRBZO3P>; Mon, 26 Feb 2001 09:29:15 -0500
Received: from zeus.kernel.org ([209.10.41.242]:53191 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130212AbRBZO2l>;
	Mon, 26 Feb 2001 09:28:41 -0500
Date: Mon, 26 Feb 2001 13:14:11 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: apic patches (with MIS counter)
In-Reply-To: <20010226111328.A24978@grobbebol.xs4all.nl>
Message-ID: <Pine.GSO.3.96.1010226122619.9420C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Feb 2001, Roeland Th. Jansen wrote:

>            CPU0       CPU1
>   0:   50644222   50826974    IO-APIC-edge  timer
>   1:     239631     233690    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   3:     344151     345715    IO-APIC-edge  serial
>   4:          4          4    IO-APIC-edge  serial
>   5:     331569     327717    IO-APIC-edge  soundblaster
>   8:     268433     271449    IO-APIC-edge  rtc
>  14:     919801     913328    IO-APIC-edge  ide0
>  15:      22625      21407    IO-APIC-edge  ide1
>  18:     149973     150537   IO-APIC-level  BusLogic BT-930
>  19:    5557525    5554806   IO-APIC-level  eth0
> NMI:  101420638  101425054
> LOC:  101475956  101475952
> ERR:         90
> MIS:      34865

 The mismatch to IRQ count ratio looks sane. 

> it seems like it is time to get at least the suggestions so far in the
> mainstream kernel or at least in Alan's tree. (it's not clear if it has
> been already included)

 It is already present in 2.4.2-ac3.

> There are a few things that might be related though -- some slow network
> performance but I am not sure if that is caused by the patch. I don't
> think so but..; I also didn't hammer the whole day on sound to crash it.

 There is a small performance impact at every interrupt -- the code that
checks for mismatches incurs it.  It's just a few CPU instructions, thus
it should not be noticeable.

> if you like, I can start banging the machine on it's head now.

 Please do.  I believe the code is safe to be included in 2.4.3, but if
any problem is going to pop up, it'd better do it before than after
applying to the mainstream. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

