Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292507AbSCAP7E>; Fri, 1 Mar 2002 10:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293005AbSCAP6y>; Fri, 1 Mar 2002 10:58:54 -0500
Received: from mail.internet-factory.de ([195.122.142.5]:23232 "EHLO
	mail.internet-factory.de") by vger.kernel.org with ESMTP
	id <S292507AbSCAP6n>; Fri, 1 Mar 2002 10:58:43 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Holger Lubitz <h.lubitz@internet-factory.de>
Newsgroups: lists.linux.kernel
Subject: Re: Yet another disk transfer speed problem
Date: Fri, 01 Mar 2002 16:58:36 +0100
Organization: Internet Factory AG
Message-ID: <3C7FA52C.E0A1715E@internet-factory.de>
In-Reply-To: <1014914087.3274.22.camel@wavelets.mit.edu> <1014926801.3274.40.camel@wavelets.mit.edu>
NNTP-Posting-Host: bastille.internet-factory.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: darkstar.internet-factory.de 1014998317 8144 195.122.142.158 (1 Mar 2002 15:58:37 GMT)
X-Complaints-To: usenet@internet-factory.de
NNTP-Posting-Date: 1 Mar 2002 15:58:37 GMT
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre3-ac2 i686)
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bharath Krishnan proclaimed:
> 
> Hi,
> 
> I would expect the disk which acts slower(maxtor) to be atleast as fast
> as the other one (ibm).

Could you provide fdisk -l for both? For some odd reason unknown to me
some filesystems give slower results with hdparm than others, even with
the buffer-cache reads (which are intended to measure memory speed, not
drive speed, and thus should be the same for all drives on a given
mainboard). Also, hdparm directly on the drive device is often a bit
slower than hdparm for the first (outermost) partition. These problems
have been far worse in older kernels, though. With 2.2 I once
benchmarked a vfat-partition at half the speed the same partition gave
as ext2.

Holger
