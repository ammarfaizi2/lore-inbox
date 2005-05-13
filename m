Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262643AbVEMXm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262643AbVEMXm2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 19:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262641AbVEMXji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 19:39:38 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:54957 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262592AbVEMXiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 19:38:17 -0400
Subject: Re: Hyper-Threading Vulnerability
From: Lee Revell <rlrevell@joe-job.com>
To: Dave Jones <davej@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Matt Mackall <mpm@selenic.com>,
       Andy Isaacson <adi@hexapodia.org>, Andi Kleen <ak@muc.de>,
       "Richard F. Rebel" <rrebel@whenu.com>,
       Gabor MICSKO <gmicsko@szintezis.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tytso@mit.edu
In-Reply-To: <20050513232708.GC13846@redhat.com>
References: <1115963481.1723.3.camel@alderaan.trey.hu>
	 <m164xnatpt.fsf@muc.de> <1116009483.4689.803.camel@rebel.corp.whenu.com>
	 <20050513190549.GB47131@muc.de> <20050513212620.GA12522@hexapodia.org>
	 <20050513215905.GY5914@waste.org>
	 <1116024419.20646.41.camel@localhost.localdomain>
	 <1116025212.6380.50.camel@mindpipe>  <20050513232708.GC13846@redhat.com>
Content-Type: text/plain
Date: Fri, 13 May 2005 19:38:08 -0400
Message-Id: <1116027488.6380.55.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-13 at 19:27 -0400, Dave Jones wrote:
> On Fri, May 13, 2005 at 07:00:12PM -0400, Lee Revell wrote:
>  > On Fri, 2005-05-13 at 23:47 +0100, Alan Cox wrote:
>  > > On Gwe, 2005-05-13 at 22:59, Matt Mackall wrote:
>  > > > It might not be much of a problem though. If he's a bit off per guess
>  > > > (really impressive), he'll still be many bits off by the time there's
>  > > > enough entropy in the primary pool to reseed the secondary pool so he
>  > > > can check his guesswork.
>  > > 
>  > > You can also disable the tsc to user space in the intel processors.
>  > > Thats something they anticipated as being neccessary in secure
>  > > environments long ago. This makes the attack much harder.
>  > 
>  > And break the hundreds of apps that depend on rdtsc?  Am I missing
>  > something?
> 
> If those apps depend on rdtsc being a) present, and b) working
> without providing fallbacks, they're already broken.
> 
> There's a reason its displayed in /proc/cpuinfo's flags field,
> and visible through cpuid. Apps should be testing for presence
> before assuming features are present.
> 

Well yes but you would still have to recompile those apps.  And take the
big performance hit from using gettimeofday vs rdtsc.  Disabling HT by
default looks pretty good by comparison.

Lee

