Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312169AbSDEDFl>; Thu, 4 Apr 2002 22:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312178AbSDEDFb>; Thu, 4 Apr 2002 22:05:31 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39186 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312169AbSDEDFV>; Thu, 4 Apr 2002 22:05:21 -0500
Subject: Re: faster boots?
To: bcrl@redhat.com (Benjamin LaHaise)
Date: Fri, 5 Apr 2002 04:21:30 +0100 (BST)
Cc: akpm@zip.com.au (Andrew Morton), rgooch@ras.ucalgary.ca (Richard Gooch),
        joeja@mindspring.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020404220022.F24914@redhat.com> from "Benjamin LaHaise" at Apr 04, 2002 10:00:22 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16tKI6-0007TJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I find that on heavily scsi systems: one machine spins each of 13 disks 
> up sequentially.  This makes the initial boot take 3-5 minutes before 
> init even gets its foot in the door.  If someone made a patch to spin 
> up scsi disks on the first access, I'd gladly give it a test. ;-)

Ditto. Especially if it spun them down again when idle for a while. 

The scsi layer does several things serially it could parallelise. It isnt
just disk spin up its also things like initialising all scsi controllers
in parallel.

Alan
