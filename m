Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288677AbSAQNOm>; Thu, 17 Jan 2002 08:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288685AbSAQNOd>; Thu, 17 Jan 2002 08:14:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4873 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288675AbSAQNOR>; Thu, 17 Jan 2002 08:14:17 -0500
Subject: Re: Rik spreading bullshit about VM
To: andrea@suse.de (Andrea Arcangeli)
Date: Thu, 17 Jan 2002 13:26:07 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, riel@conectiva.com.br (Rik van Riel)
In-Reply-To: <20020116200459.E835@athlon.random> from "Andrea Arcangeli" at Jan 16, 2002 08:04:59 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16RCYR-0003GW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If redhat doesn't use the -aa VM into their kernels that's either a
> political decision or they're not good enough at the VM. I can tell you

If you want to insult the Red Hat people please don't do it from a SuSE
address. There are some great people at SuSE and I somehow doubt you speak
for the management or major stockholders (ibm etc)

When Red Hat shipped 7.2 the -aa vm didn't even exist. It was 2.4.7 era -
so the choices were Rik's stuff half missing and mangled by Linus versus
Riks stuff proper (2.4.7-ac). The latter passed QA the formed choked and died.
The same basically applied for the 2.4.9 based errata - combined with
a desire to reduce unneeded change, because paying corporate customers want
certainly not neat toys. Shipping 2.4.10 to customers would have been
pretty irresponsible when it seems that in some cases even things like
fsync() didnt actually work. The O_DIRECT security bug with /dev alone I
think justified that caution.

When we tested 2.4.17 during evaluation we found it 20% slower on many I/O
heavy workloads. I don't know if -aa ever got that far in QA testing. 
I do know 2.4.17+rmap11* passes Cerberus.

>From my own testing 2.4.18pre3-aa does pretty well, its better than the
2.4.17 base until you get high loads then it gets ugly. Clearly it has a
lot of things right.

At the moment both 2.4.18pre+rmap and -aa are better than base 2.4.18pre3,
so its in your interest to actually send Marcelo the changes one at a time
with explanations to get 2.4.18 better and better, and with luck find which
change is causing the horribly heavy swap behaviour and "0 order allocation
failed" cases along the way.

Alan
