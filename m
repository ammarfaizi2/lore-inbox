Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278119AbRJLUas>; Fri, 12 Oct 2001 16:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278120AbRJLUai>; Fri, 12 Oct 2001 16:30:38 -0400
Received: from snowball.fnal.gov ([131.225.81.94]:64521 "EHLO
	snowball.fnal.gov") by vger.kernel.org with ESMTP
	id <S278119AbRJLUaa>; Fri, 12 Oct 2001 16:30:30 -0400
Date: Fri, 12 Oct 2001 15:31:00 -0500 (CDT)
From: Steven Timm <timm@fnal.gov>
To: <linux-kernel@vger.kernel.org>
cc: <alan@lxorguk.ukuu.org.uk>
Subject: re: DMA problem (?) w/2.4.6-xfs and Serverworks OSB4 Chipset
Message-ID: <Pine.LNX.4.31.0110121527330.22455-100000@snowball.fnal.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I had previously reported DMA problems with ultraDMA using
Serverworks OSB4 (LE) chipset talking to IDE drives including
Western Digital and Seagate.

I am now running 2.4.9-0.18 kernel as found at Redhat's Rawhide
which includes Alan's latest diagnostic patches, and am getting
the message like this:

end_request: I/O error, dev 16:01 (hdc), sector 2487128
Curious - OSB4 thinks the DMA is still running.
OSB4 wait exit.
hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=2487198,
sector=2487128

------------------------

with the "Curious..." patch being the new diagnostics added by Alan.
All the various failure modes which we see include this error
message now.

What does this imply...is there any hope for a fix?

Steve Timm


------------------------------------------------------------------
Steven C. Timm (630) 840-8525  timm@fnal.gov  http://home.fnal.gov/~timm/
Fermilab Computing Division/Operating Systems Support
Scientific Computing Support Group--Computing Farms Operations

