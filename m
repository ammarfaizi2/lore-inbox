Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262668AbUKMDsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262668AbUKMDsP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 22:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262735AbUKMDsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 22:48:15 -0500
Received: from siaag2ab.compuserve.com ([149.174.40.132]:45539 "EHLO
	siaag2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S262668AbUKMDsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 22:48:11 -0500
Date: Fri, 12 Nov 2004 22:45:13 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: deadlock with 2.6.9
To: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200411122248_MC3-1-8E97-BFE6@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 Nov 2004 at 09:22:14 +0100 Bernd Eckenfels wrote:

> > Get a real RAID controller (3Ware, not some crappy pseudo-RAID junk.)  They are
> > much more reliable than software RAID.
>
> On what sample do you base this claim?
>
> Generally hardware raid sooner or later makes problems (especially if you
> run raid5 in degenerate mode or try to rebuild by disk replacing with
> differen/old signature). Also bus hangs are commonly not very well received
> by hw raid firmware or drivers.

  I had 28 mirror sets on Compaq SMART2/p controllers in one server (four
controllers, two SCSI channels each, seven disks per channel.)  All the disks
on channel A of each controller were mirrored to those on channel B, so even
complete failure of one channel didn't cause a problem.

  Once a disk was marked 'failed' in the controller NVRAM there was no way to
convince it that some newly-inserted disk contained valid data.

  Booting up with SCSI cables connected wrongly (channels A and B swapped) got you
a nice error message informing you of this fact.  Swapping SCSI IDs on different
disks on the same channel was also detected and reported nicely.

  And attempting to boot with a bad cable (bent pin) gave a message saying 'either
power down NOW and check cables or I will mark every disk on that channel as
failed.'

  Of course this system was 100% Compaq; even the disks had Compaq firmware
though the labels said IBM.  And it was very expensive...


--Chuck Ebbert  12-Nov-04  22:42:32
