Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262882AbVGHV4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbVGHV4M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 17:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262829AbVGHVxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 17:53:46 -0400
Received: from smtpauth06.mail.atl.earthlink.net ([209.86.89.66]:28908 "EHLO
	smtpauth06.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S262902AbVGHVvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 17:51:33 -0400
From: Sheo Shanker Prasad <ssp@creativeresearch.org>
Organization: Creative Research Enterprises
To: Philippe Troin <phil@fifi.org>
Subject: Re: Disturbing wide variation in execution time
Date: Fri, 8 Jul 2005 14:51:27 -0700
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <200507062344.53615.ssp@creativeresearch.org> <87oe9eo3n5.fsf@ceramic.fifi.org>
In-Reply-To: <87oe9eo3n5.fsf@ceramic.fifi.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507081451.27563.ssp@creativeresearch.org>
X-ELNK-Trace: c9e54813b5d7ed8a1e28108c03118538416dc04816f3191cb436338f62802c0ae0c529f19e8309e4718ea40762408fdc350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.4.45.120
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday July 7 2005 11:46 am, Philippe Troin wrote:
> Sheo Shanker Prasad <ssp@creativeresearch.org> writes:
> > I will appreciate your help in eliminating a disturbing wide
> > variation (by a factors of 2 to 2.5) in the execution time of a test
> > (execution benchmark) program under identical conditions even when
> > the machine is freshly started (rebooted) and no other user program
> > is running (not even e-mail or Internet browser).
> >
> > I have a dual Opteron 250 (2.4 GHz) running SuSE 9.3 Pro & Linux
> > version 2.6.11.4-21.7-smp (geeko@buildhost) (gcc version 3.3.5
> > 20050117 (prerelease) (SUSE Linux)) #1 SMP Thu Jun 2 14:23:14 UTC
> > 2005. The motherboard is Tyan Thunder K8W (S2885 ANRF) with AMI BIOS
> >
> > The machine has 4GB of PC3200 DDR RAM, two dimms on each CPU.
> >
> > The original machine bought from a vendor about 6 months ago. At
> > that time it was running SuSE 9.1 Pro and the execution time for the
> > same test program was consistently the same (around 2m 37s +/- a few
> > %). Then the mother board failed and the machine went totally
> > dead. The vendor then replaced the failed motherboard with a new
> > Tyan Thunder K8W and installed the SuSE 9.3. I am not sure whether
> > or not the AMI BIOS was also replaced.
> >
> > When the repaired machine was started, I began to notice the
> > disturbing wide variation and the frequect significant slow down of
> > the machine as exhibited by the factor of 2 to 2.5 increased
> > execution time of the test program as described above.  Sometimes it
> > would be quite fast (executing at the original 2m 40s) and sometime
> > a factor of 2.5 slow, and sometimes with speed in between.
>
> 8< snip >8

Thanks very much for your taking time to think about my problem. Here are 
answers to your questions.
>
>  1. Are you running an i386 kernel or an x86_64 kernel?

I think, I am running a x86_64 kernel.  I think so, because I had asked the 
vendor of the machine to install x86_64 and because the file

System.map-2.6.11.4-21.7-smp 

in the /boot directory has an entry: ffffffff804f0000 T x86_64_start_kernel

and that directory also contains the gzipped file:

 symvers-2.6.11.4-21.7-x86_64-smp.gz

The operating system is Linux version 2.6.11.4-21.7-smp (geeko@buildhost)  
(gcc version 3.3.5 20050117 (prerelease) (SUSE Linux)) #1 SMP Thu Jun 2 
14:23:14 UTC 2005
>
>  2. Which BIOS version?

The BIOS is AMIBIOS version is 08.00.10 with the build date of 02/11/05 
09:44:04 and has the ID:  0AAAA001.

>
>  3. Is node interleaving enabled in the BIOS?

When I go through the BIOS setup, I do not see any choice for the node 
interleaving ON or OFF. However, I think that the two CPUs (as node0 and 
node1) are made NUMA aware by default, but I could be quite wrong. 

Out of ignorance, therefore,  the following are the contents of 

 /sys/devices/system/node/node0/numastat &

numa_hit 3620274
numa_miss 0
numa_foreign 0
interleave_hit 21903
local_node 3610298agravaited
other_node 9976

Similarly, following are the  the contents of

  /sys/devices/system/node/node1/numastat

numa_hit 3089426
numa_miss 0
numa_foreign 0
interleave_hit 38355
local_node 3072605
other_node 16821

>
> Phil.

 Thanks again, Phil, and I hope to hear from you soon.
-- 
Best regards.

Sheo
(Sheo S. Prasad)
Creative Research Enterprises
6354 Camino del Lago
Pleasanton, CA 94566, USA
Voice Phone: (+1) 925 426-9341
Fax   Phone: (+1) 925 426-9417
e-mail: ssp@CreativeResearch.org

