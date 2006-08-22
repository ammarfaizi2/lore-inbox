Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbWHVUY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbWHVUY7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 16:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWHVUY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 16:24:59 -0400
Received: from mail0.lsil.com ([147.145.40.20]:48303 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1751259AbWHVUY6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 16:24:58 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: HELP: GIT Cloning failed
Date: Tue, 22 Aug 2006 14:24:34 -0600
Message-ID: <890BF3111FB9484E9526987D912B261932E35C@NAMAIL3.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: HELP: GIT Cloning failed
Thread-Index: AcbGJrr698AbTL/ARJ6C3NVQm/onBgAATNxA
From: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
To: "Sean" <seanlkml@sympatico.ca>
Cc: <git@vger.kernel.org>, "Patro, Sumant" <Sumant.Patro@engenio.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Aug 2006 20:24:34.0765 (UTC) FILETIME=[FB8867D0:01C6C628]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Tuesday, August 22, 2006 4:08 PM, Sean  wrote:
> It looks like the jejb scsi-misc archive might not have been
> configured properly for http transfers.  There's a script below
> which just uses git commands (not cogito) and the native git
> protocol which tests out okay here.
I will try with the script and rest of your comments as well.
Thank you for your guidence.

Regards,

Seokmann


> -----Original Message-----
> From: Sean [mailto:seanlkml@sympatico.ca] 
> Sent: Tuesday, August 22, 2006 4:08 PM
> To: Ju, Seokmann
> Cc: git@vger.kernel.org; Patro, Sumant; linux-kernel@vger.kernel.org
> Subject: Re: HELP: GIT Cloning failed
> 
> On Tue, 22 Aug 2006 13:25:23 -0600
> "Ju, Seokmann" <Seokmann.Ju@lsil.com> wrote:
> 
> Ju,
> 
> > Above script worked without any problem when I started 
> several months
> > ago and I'm not sure when did it stop working.
> > I'm using _cron_ utility on my Linux box for scheduled 
> execution of the
> > script.
> > 
> > Any comment would be appreciated.
> 
> It looks like the jejb scsi-misc archive might not have been
> configured properly for http transfers.  There's a script below
> which just uses git commands (not cogito) and the native git
> protocol which tests out okay here.
> 
> A few comments though:
> 
>  - Apparently the scsi misc tree you want is actually under "jejb"
>    rather than "marcelo" which you had in your script.
> 
>  - It's better to use the native git protocol when possible
>    (well, the benefits are less on initial clone, but it's still
>    a good practice)
> 
>  - You're causing a lot of unnecessary traffic for kernel.org by
>    cloning a fresh copy of all these trees, it would be much better
>    to clone just _once_ and then simply "git pull" in any updates.
> 
>  - Two of the trees you're cloning are very close in content to
>    each other (linux-2.6 & scsi-misc-2.6) so you can use the git
>    "--reference" option to share local objects saving disk space
>    (and reducing bandwidth needs even further)
> 
> Cheers,
> Sean
> 
> #!/bin/sh
> cd /home/git/kernels/2.4 || exit
> BASE="git://www.kernel.org/pub/scm/linux/kernel/git"
> rm -rf linux-2.4 linux-2.6 scsi-misc-2.6
> git clone $BASE/marcelo/linux-2.4
> git clone $BASE/torvalds/linux-2.6
> git clone --reference linux-2.6 $BASE/jejb/scsi-misc-2.6
> 
> 
> 
> 
