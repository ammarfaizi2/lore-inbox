Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261721AbSJZAKS>; Fri, 25 Oct 2002 20:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261723AbSJZAKS>; Fri, 25 Oct 2002 20:10:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61713 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261721AbSJZAKR>;
	Fri, 25 Oct 2002 20:10:17 -0400
Message-ID: <3DB9DED0.5050809@pobox.com>
Date: Fri, 25 Oct 2002 20:16:16 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
CC: Robert Love <rml@tech9.net>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "'akpm@digeo.com'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'chrisl@vmware.com'" <chrisl@vmware.com>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>
Subject: Re: [PATCH] hyper-threading information in /proc/cpuinfo
References: <F2DBA543B89AD51184B600508B68D4000EA1718C@fmsmsx103.fm.intel.com> <1035581420.734.3873.camel@phantasy> <20021026000137.GA19673@suse.de> <3DB9DC1D.3000807@pobox.com> <20021026001250.GA19948@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>On Fri, Oct 25, 2002 at 08:04:45PM -0400, Jeff Garzik wrote:
>
> > Not really... we print out other information that is duplicated N times, 
> > because it is the common case that N-way systems have matched processors 
> > with matched capabilities.
>
>Not really. We print out the 'duplicate' info because it's read that
>way from different CPUs. The smp_num_siblings is a single global
>variable. Theoretically, the other stuff /could/ change in an
>asymetrical system, but the num_siblings thing is constant.
>  
>


Sure, but you snipped the other part of the argument :)  Printing stuff 
only once is changes the format which has previously been to print out 
the same fields [but not necessarily the same values] for each CPU; so 
the alternative is to create /proc/global_cpu_info just to print out 
num-siblings only once :)  IOW, I don't see it as a big deal to print 
out the duplicated info, because that maintains the other assumptions 
about output format.

That said, on IRC my preference was to create smp_num_siblings[] and 
store the info per-cpu.  But right now that's only for software 
engineering masturbation :) since it would store the same value N times 
on current CPUs.

    Jeff




