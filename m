Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262464AbSKHVcK>; Fri, 8 Nov 2002 16:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262450AbSKHVbM>; Fri, 8 Nov 2002 16:31:12 -0500
Received: from [195.39.17.254] ([195.39.17.254]:12804 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262452AbSKHVbI>;
	Fri, 8 Nov 2002 16:31:08 -0500
Date: Wed, 16 Jan 2002 14:35:46 -0500
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@codemonkey.org.uk>, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org, "Nakajima, Jun" <jun.nakajima@intel.com>,
       chrisl@vmware.com, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [PATCH] How to get number of physical CPU in linux from user space?
Message-ID: <20020116193539.GC2947@zaurus>
References: <F2DBA543B89AD51184B600508B68D4000EA170E9@fmsmsx103.fm.intel.com> <1035572950.1501.3429.camel@phantasy> <20021025191356.GA11189@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021025191356.GA11189@suse.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > +#ifdef CONFIG_SMP
>  > +	seq_printf(m, "physical processor ID\t: %d\n", phys_proc_id[n]);
>  > +	seq_printf(m, "number of siblings\t: %d\n", smp_num_siblings);
>  > +#endif
> 
> Should this be wrapped in a if (cpu_has_ht(c)) { }  ?
> Seems silly to be displaying HT information on non-HT CPUs.

Well, without if () you can tell the difference
between 'no hyperthreading' and 'too old
kernel to tell me about hyperthreading so I'd
suggest kill the if ().
				Pavel
