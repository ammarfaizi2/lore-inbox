Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273261AbRKDTNx>; Sun, 4 Nov 2001 14:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273796AbRKDTNd>; Sun, 4 Nov 2001 14:13:33 -0500
Received: from mail.scsiguy.com ([63.229.232.106]:1809 "EHLO aslan.scsiguy.com")
	by vger.kernel.org with ESMTP id <S273261AbRKDTNZ>;
	Sun, 4 Nov 2001 14:13:25 -0500
Message-Id: <200111041913.fA4JDKY69597@aslan.scsiguy.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: linux-kernel@vger.kernel.org, groudier@club-internet.fr
Subject: Re: Adaptec vs Symbios performance 
In-Reply-To: Your message of "Sun, 04 Nov 2001 19:35:20 +0100."
             <20011104193520.1867ae7e.skraw@ithnet.com> 
Date: Sun, 04 Nov 2001 12:13:20 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hm, what more specific can I tell you, than:

Well, the numbers paint a different picture than your pervious
comments.  You never mentioned a performance disparity, only a
loss in interactive performance.

>Take my box with
>
>Host: scsi1 Channel: 00 Id: 03 Lun: 00
>  Vendor: TEAC     Model: CD-ROM CD-532S   Rev: 1.0A
>  Type:   CD-ROM                           ANSI SCSI revision: 02
>Host: scsi0 Channel: 00 Id: 08 Lun: 00
>  Vendor: IBM      Model: DDYS-T36950N     Rev: S96H
>  Type:   Direct-Access                    ANSI SCSI revision: 03
>
>and an aic7xxx driver.

A full dmesg would be better.  Right now I have no idea what kind
of aic7xxx controller you are using, the speed and type of CPU,
the chipset in the machine, etc. etc.  In general, I'd rather see
the raw data than a version edited down based on the conclusions
you've already drawn or on what you feel is important.

>Start xcdroast an read a cd image. You get something
>between 2968,4 and 3168,2 kB/s throughput measured from xcdroast.
>
>Now redo this with a Tekram controller (which is sym53c1010) and you get
>throughput of 3611,1 to 3620,2 kB/s.

Were both tests performed from cold boot to a new file in the same
directory with similar amounts of that filesystem in use?

>No special stuff or background processes or anything else involved. I wonder
>how much simpler a test could be.

It doesn't matter how simple it is if you've never mentioned it before.
Your tone is somewhat indignant.  Do you not understand why this
data is important to understanding and correcting the problem?

>Give me values to compare from _your_ setup.

Send me a c1010. 8-)

>If you redo this test with nfs-load (copy files from some client to your
>test-box acting as nfs-server) you will end up at 1926 - 2631 kB/s throughput
>with aic, but 3395 - 3605 kB/s with symbios.

What is the interrupt load during these tests?  Have you verified that
disconnection is enabled for all devices on the aic7xxx controller?

>If you need more on that picture, then redo the last and start _some_
>application in the background during the test (like mozilla). Time how long it
>takes until the application is up and running. 

Since you are experiencing the problem, can't you time it?  There is
little guarantee that I will be able to reproduce the exact scenario
you are describing.  As I mentioned before, I don't have a c1010,
so I cannot perform the comparison you feel is so telling.

This does not look like an interrupt latency problem.

--
Justin
