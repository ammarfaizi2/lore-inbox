Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286322AbSCFANg>; Tue, 5 Mar 2002 19:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290806AbSCFANd>; Tue, 5 Mar 2002 19:13:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48650 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286322AbSCFANT>; Tue, 5 Mar 2002 19:13:19 -0500
Subject: Re: [PATCH] 2.5.6-pre2 IDE cleanup 16
To: aia21@cam.ac.uk (Anton Altaparmakov)
Date: Wed, 6 Mar 2002 00:27:39 +0000 (GMT)
Cc: dalecki@evision-ventures.com (Martin Dalecki),
        zwane@linux.realnet.co.sz (Zwane Mwaikambo),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <5.1.0.14.2.20020305122312.026b9180@pop.cus.cam.ac.uk> from "Anton Altaparmakov" at Mar 05, 2002 12:36:54 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16iPHQ-0004sL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At 11:48 05/03/02, Martin Dalecki wrote:
> >5. No body is using it as of now and therefore nobody should miss it.
> 
> That is a very bold statement which is incorrect. I remember reading at 
> least one post to lkml from a company who is using the Taskfile ioctls and 

I know several people using them, and for some ioctl operations they are
required. In fact without taskfile ioctl stuff I can't make my laptop resume
correctly for example. (it needs proper drive please wake up sequences to
go the ibm microdrive)

At this point I think you've overstepped the mark. The taskfile stuff is
rather important. If you don't understand why please read the ATA6 standard
and look at the sequence of phases. Think of it as a scsi sequencer in 
kernel space because the hardware isnt bright enough to do it.

Alan
