Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274018AbRI0Wuc>; Thu, 27 Sep 2001 18:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274031AbRI0WuW>; Thu, 27 Sep 2001 18:50:22 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22802 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274018AbRI0WuS>; Thu, 27 Sep 2001 18:50:18 -0400
Subject: Re: DMA problem (?) w/2.4.6-xfs and ServerWorks OSB4 Chipset
To: timm@fnal.gov (Steven Timm)
Date: Thu, 27 Sep 2001 23:55:33 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.31.0109271622520.28262-100000@snowball.fnal.gov> from "Steven Timm" at Sep 27, 2001 04:34:31 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15mk45-0005Li-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.4.7-ac2 patch level and not having any lock-ups with ultraDMA.
> My question--there was a new file "serverworks.c" inserted in the
> 2.4.6 ac patches.  Does anyone know if that made it into the kernel
> and supposedly fixed the problem?  (My guess is that it has *not*

Short answer is "it should"

Long answer "I have been chasing a specific problem with OSB4, seagate
drives and UDMA corruption. We can reliably reproduce it and see it on one
set of machines. Serverworks cannot reproduce it elsewhere"

So unless your box when running current -ac starts spewing messages about
DMA completions seeming broken - it should work. I only mention this
because you write:

> We have seen quite a difference on systems that are otherwise
> the same (Supermicro 370DLE w/serverworks OSB4 LE chipset) by swapping
> different models of hard disk drives.  With some types of drive
> (Seagate) we
> observe massive corruption of the file system but nothing reported
> in /var/log/messages or on the console.  Currently we see hda
> timeouts (but only on about 10 systems over the course of 2 months)
> which hang the machine but after a reboot things are fine (Western
> Digital).

I would thus be very interested if the current -ac "hardware just did
something impossibly stupid" trap is hit.

Alan
