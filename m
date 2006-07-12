Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbWGLVaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbWGLVaB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 17:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbWGLVaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 17:30:00 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:37295 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750901AbWGLVaA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 17:30:00 -0400
Subject: Re: xfs fails dbench in 2.6.18-rc1-mm1
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Martin Bligh <mbligh@google.com>
Cc: Eric Dumazet <dada1@cosmosbay.com>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <44B55AEA.1010608@google.com>
References: <44B52A19.3020607@google.com>
	 <200607121912.52785.dada1@cosmosbay.com> <44B557DA.2050208@google.com>
	 <44B55A9E.2010403@us.ibm.com>  <44B55AEA.1010608@google.com>
Content-Type: text/plain
Date: Wed, 12 Jul 2006 14:32:19 -0700
Message-Id: <1152739939.22840.1.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-12 at 13:26 -0700, Martin Bligh wrote:
> Badari Pulavarty wrote:
> > Martin Bligh wrote:
> > 
> >> Eric Dumazet wrote:
> >>
> >>> On Wednesday 12 July 2006 18:58, Martin Bligh wrote:
> >>>
> >>>> http://test.kernel.org/abat/40891/debug/test.log.1
> >>>>
> >>>> Filesystem type for /mnt/tmp is xfs
> >>>> write failed on handle 13786
> >>>> 4 clients started
> >>>> Child failed with status 1
> >>>> write failed on handle 13786
> >>>> write failed on handle 13786
> >>>> write failed on handle 13786
> >>>>
> >>>> Works fine in -git4
> >>>> All other fs's seemed to run OK.
> >>>>
> >>>> Machine is a 4x Opteron.
> >>>
> >>>
> >>>
> >>> You need to revert 92eb7a2f28d551acedeb5752263267a64b1f5ddf
> >>
> >>
> >> Still fails (thanks Andy).
> >>
> > Wondering if its my changes :(
> > Can you back out these and try ?
> > 
> > Please, Please tell me that, its not me :)
> > 
> > Thanks,
> > Badari
> > 
> > #
> > vectorize-aio_read-aio_write-fileop-methods.patch
> > remove-readv-writev-methods-and-use-aio_read-aio_write.patch
> > streamline-generic_file_-interfaces-and-filemap.patch
> > streamline-generic_file_-interfaces-and-filemap-ecryptfs.patch
> 
> You could submit a job to elm3b6 to run dbench on xfs ;-)
> 
> M.


I am not able to "insmod xfs.ko" on my x86-64 machine :(

elm3b29:~ # modprobe xfs
FATAL: Error inserting xfs (/lib/modules/2.6.18-rc1-
mm1/kernel/fs/xfs/xfs.ko): Cannot allocate memory

#dmesg shows ..

Could not allocate 8 bytes percpu data
Could not allocate 8 bytes percpu data
Could not allocate 8 bytes percpu data
Could not allocate 8 bytes percpu data
Could not allocate 8 bytes percpu data
Could not allocate 8 bytes percpu data
Could not allocate 328 bytes percpu data
Could not allocate 328 bytes percpu data
Could not allocate 328 bytes percpu data


Whats happening here ?

Thanks,
Badari

