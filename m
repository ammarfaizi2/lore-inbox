Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314529AbSGSE5F>; Fri, 19 Jul 2002 00:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315445AbSGSE5F>; Fri, 19 Jul 2002 00:57:05 -0400
Received: from smtp.eol.ca ([205.189.152.19]:29383 "HELO smtp.eol.ca")
	by vger.kernel.org with SMTP id <S314529AbSGSE5F>;
	Fri, 19 Jul 2002 00:57:05 -0400
Date: Fri, 19 Jul 2002 01:00:06 -0400
From: William Park <opengeometry@yahoo.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: Dual Athlon MP 1900+ on MSI K7D Master-L
Message-ID: <20020719050006.GB3590@node1.opengeometry.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200207190331.57158.Dieter.Nuetzel@hamburg.de> <200207182114.30806.kelledin+LKML@skarpsey.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207182114.30806.kelledin+LKML@skarpsey.dyndns.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 09:14:30PM -0500, Kelledin wrote:
> On Thursday 18 July 2002 08:31 pm, Dieter N?tzel wrote:
> > Alan, were should I put the "-j2/-j3" make flag for the kernel
> > compilation? /usr/src/linux/Documentation/smp.txt is way
> > outdated ;-(
...
> In general, I find it best to set the number of jobs to the 
> number of CPUs _plus 1_--i.e. for single CPU, use make -j2, and 
> for dual CPUs, use make -j3.  Going for that "plus 1" makes most 
> builds just a smidgen faster.  For me, on my dual PPro box, the 
> process would be something like:
> 
> make menuconfig
> make -j3 MAKE="make -j3" dep clean bzImage modules

I usually have better luck if I use only one target per 'make':
    make menuconfig
    make -j3 dep
    make clean
    make -j3 bzlilo
    make -j3 modules
    make -j3 modules_install
Especially, 'modules' and 'modules_install' must be done separately.

-- 
William Park, Open Geometry Consulting, <opengeometry@yahoo.ca>
8-CPU Cluster, Hosting, NAS, Linux, LaTeX, python, vim, mutt, tin
