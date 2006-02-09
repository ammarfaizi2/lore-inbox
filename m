Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbWBIRX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWBIRX5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 12:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbWBIRX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 12:23:56 -0500
Received: from proof.pobox.com ([207.106.133.28]:16606 "EHLO proof.pobox.com")
	by vger.kernel.org with ESMTP id S932371AbWBIRX4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 12:23:56 -0500
Date: Thu, 9 Feb 2006 11:23:43 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Ashok Raj <ashok.raj@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Eric Dumazet <dada1@cosmosbay.com>,
       riel@redhat.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       mingo@elte.hu, ak@muc.de, 76306.1226@compuserve.com, wli@holomorphy.com,
       heiko.carstens@de.ibm.com, Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Message-ID: <20060209172342.GN18730@localhost.localdomain>
References: <20060209160808.GL18730@localhost.localdomain> <20060209090321.A9380@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060209090321.A9380@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj wrote:
> On Thu, Feb 09, 2006 at 08:08:09AM -0800, Nathan Lynch wrote:
> > 
> >    powerpc/ppc64, for instance, determines the number of possible cpus
> >    from information exported by firmware (and I'm mystified as to why
> >    other platforms don't do this).  So it's typical to have a kernel an a
> >    pSeries partition with NR_CPUS=128, but cpu_possible_map = 0xff.
> > 
> 
> Iam assuming in the above ase, cpu_possible_map == cpu_present_map and both
> dont change after the OS is booted. v.s in platforms capable of hot-plug
> cpus present could grow up to cpu_possible_map (max) when a new cpu is
> newly added, that wasnt even present at boot time.

No, cpu_present_map need not equal cpu_possible_map.  Of course
cpu_possible_map doesn't change after boot, but cpu_present_map can.
Apart from that, I don't really understand what you're trying to say
here.

