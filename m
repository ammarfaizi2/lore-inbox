Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262450AbSKTTS2>; Wed, 20 Nov 2002 14:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262631AbSKTTS2>; Wed, 20 Nov 2002 14:18:28 -0500
Received: from host194.steeleye.com ([66.206.164.34]:55302 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S262450AbSKTTS1>; Wed, 20 Nov 2002 14:18:27 -0500
Message-Id: <200211201925.gAKJPTx03466@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Patrick Mansfield <patmans@us.ibm.com>
cc: Christoph Hellwig <hch@lst.de>, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove unused includes and misleading comments from 
 scsi_lib.c
In-Reply-To: Message from Patrick Mansfield <patmans@us.ibm.com> 
   of "Wed, 20 Nov 2002 11:10:16 PST." <20021120111016.A20388@eng2.beaverton.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 20 Nov 2002 13:25:29 -0600
From: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patmans@us.ibm.com said:
> It is in hardirq.h, arch specific, 11 of the 20 hardirq.h files would
> need the change (they reference kernel_locked) to include smp_lock.h.

> 665 files include smp_lock.h 89  files include hardirq.h 32  files
> include both

> So, should I change the arch hardirq.h files to include smp_lock.h, or
> just add smp_lock.h to scsi_lib.c? 

That magnitude of change needs to go in through the header files project.  
I'll just apply the smp_lock.h in scsi_lib fix to the scsi tree for now.  They 
can always take it out again for the proper fix.

James


