Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261606AbSJYUt3>; Fri, 25 Oct 2002 16:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261607AbSJYUt3>; Fri, 25 Oct 2002 16:49:29 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:24519 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261606AbSJYUt2>; Fri, 25 Oct 2002 16:49:28 -0400
Subject: Re: [PATCH] How to get number of physical CPU in linux from user
	space?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Love <rml@tech9.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, chrisl@vmware.com,
       "Martin J. Bligh" <mbligh@aracnet.com>
In-Reply-To: <1035572950.1501.3429.camel@phantasy>
References: <F2DBA543B89AD51184B600508B68D4000EA170E9@fmsmsx103.fm.intel.com> 
	<1035572950.1501.3429.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Oct 2002 22:13:04 +0100
Message-Id: <1035580384.13032.84.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-25 at 20:09, Robert Love wrote:

> +#ifdef CONFIG_SMP
> +	seq_printf(m, "physical processor ID\t: %d\n", phys_proc_id[n]);
> +	seq_printf(m, "number of siblings\t: %d\n", smp_num_siblings);
> +#endif

Congratulations you just broke glibc. There are reasons the -ac patch
was changed to print something a little different.

