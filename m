Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267510AbRGRR5q>; Wed, 18 Jul 2001 13:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267867AbRGRR5f>; Wed, 18 Jul 2001 13:57:35 -0400
Received: from stine.vestdata.no ([195.204.68.10]:62735 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S267510AbRGRR5V>; Wed, 18 Jul 2001 13:57:21 -0400
Date: Wed, 18 Jul 2001 19:57:23 +0200
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <xfs@ragnark.vestdata.no>
To: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: kernel deadlock; xfs
Message-ID: <20010718195723.A24237@vestdata.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

We're experiencing a deadlock on a NFS-server using a XFS filesystem.
The kernel was originally running SGI XFS 1.0, but we've now tried 1.0.1
and the CVS-version (as of yesterday) - same problem.

The deadlock appear to be happening when accessing big files over NFS,
but we're not sure as we have not found a way to reproduce. There are no
kernel messages written to syslog, and the kernel debugger does not
start when pressing pause.

I assume that means the problem is inside an interrupt handler? Does
that exclude XFS as the potential problem?

The system is using aic7xxx SCSI adapters and hamachi gigabit ethernet
card.

We're going to try with a different filesystem and a different gigabit
card next, but if you have other suggestions for how to debug this,
please let us know.



-- 
Ragnar Kjorstad
Big Storage
