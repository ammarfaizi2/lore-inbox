Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130297AbRCBCtW>; Thu, 1 Mar 2001 21:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130292AbRCBCtD>; Thu, 1 Mar 2001 21:49:03 -0500
Received: from [209.102.105.34] ([209.102.105.34]:47625 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S130290AbRCBCs4>;
	Thu, 1 Mar 2001 21:48:56 -0500
Date: Thu, 1 Mar 2001 18:48:43 -0800
From: Tim Wright <timw@splhi.com>
To: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
Cc: "Matilainen Panu (NRC/Helsinki)" <panu.matilainen@nokia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.x very unstable on 8-way IBM 8500R
Message-ID: <20010301184843.B5065@kochanski.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>,
	"Matilainen Panu (NRC/Helsinki)" <panu.matilainen@nokia.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0103011229500.23756-100000@godzilla.research.nokia.com> <Pine.LNX.4.21.0103011701360.8542-100000@sol.compendium-tech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0103011701360.8542-100000@sol.compendium-tech.com>; from kernel@blackhole.compendium-tech.com on Thu, Mar 01, 2001 at 05:04:09PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2001 at 05:04:09PM -0800, Dr. Kelsey Hudson wrote:
> On Thu, 1 Mar 2001, Matilainen Panu (NRC/Helsinki) wrote:
> 
> > I've been playing around with 8-way IBM8500R (8x700MHz Xeon) with 4.5GB
> > memory & AIC7xxx SCSI-controller. It's perfectly stable with 2.2-kernel
> > (from Red Hat 7) but very erratic on all 2.4-kernels I've tried it with
> > (2.4.[012], compiled both with egcs and RH7's gcc-2.96, both share the
> 
> Under redhat 7 you should use kgcc to compile the kernel, since gcc2.96 is
> inherently broken(*). 
> 

For the umpteenth time, no it isn't. There are serious bugs in the shipped
version of gcc in RedHat 7.0, but they are fixed by applying the update.
The reason for supplying kgcc is to allow building a 2.2 kernel, because of
bugs in the kernel, NOT the compiler.

> > same symptoms). It did have a ServeRAID controller too but IBM suggested
> > we take it out since 4500R also had problems with it on 2.4 but it didn't
> > make any difference at all. Also tried to turn off highmem support but
> > didn't make difference either.
> 
> (*)  redhat chose to ship an experimental compiler with this release of
>      the distribution that has a great many bugs. to ensure proper kernel
>      compillation another proven version of gcc was included, but called
>      kgcc instead. You should always use this to compile your kernels
>      under redhat 7 until the newer version of gcc is released.
> 

No. Provided you grab the update, you can build the 2.4 kernel perfectly
happily using the RedHat gcc snapshot. I'm running it successfully on a number
of machines. The issue with 2.4 on certain Netfinities is a bad interaction
between the NMI watchdog code and the systems management card. Changing
compilers makes no difference.

Tim

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
