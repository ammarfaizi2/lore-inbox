Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312386AbSCUQEt>; Thu, 21 Mar 2002 11:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312384AbSCUQEf>; Thu, 21 Mar 2002 11:04:35 -0500
Received: from dsl-65-188-226-101.telocity.com ([65.188.226.101]:62478 "HELO
	fancypants.trellisinc.com") by vger.kernel.org with SMTP
	id <S312383AbSCUQEO>; Thu, 21 Mar 2002 11:04:14 -0500
Date: Thu, 21 Mar 2002 11:04:12 -0500
From: nicholas black <dank@trellisinc.com>
To: linux-kernel@vger.kernel.org
Cc: lionel.bouton@inet6.fr, marcelo@connectiva.com.br
Subject: sis 5591 ide in 2.4.19-pre3 consumes souls
Message-ID: <20020321110412.A6558@fancypants.trellisinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yesterday night i excitedly came home to my shiny new -pre3, to discover
that on boot, all ide devices timeout on DMA requests.  i'm using the
sis ide driver on my sis 5591 controller, which is integrated onto an
amptron 810 motherboard.  

i haven't had a chance to capture exact logs yet, but can do testing
tonight.  exact behavior follows:

rebooted with 2.4.19-pre3-jl11 (preemptive; jl11 is a patch to
networking code that should play no role here).  hard drive hda and
cdrom's hdc,hdd are detected.  upon partition check of hda1, the system
hung for roughly 20 seconds, after which it was declared dma commands
had timed out.  this was repeated for all other partitions on the drive,
after which the kernel panicked, unable to mount the root fs.

this behavior continued to manifest over any number of reboots.
interestingly, i could get my old 2.4.18-jl11 (non-preempt) to work
fine, but only after a hard power down.  reboots left it in the same
situation, but not logging nearly so much to the console :).

-- 
nicholas black (dank@trellisinc.com)
"c has types for a reason.  c++ improved the type system for a reason.  perl
 and php programs have run-time failures for a reason." - lkml
