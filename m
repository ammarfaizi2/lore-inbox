Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWATWm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWATWm2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 17:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWATWm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 17:42:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7328 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932250AbWATWm1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 17:42:27 -0500
Date: Fri, 20 Jan 2006 14:41:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: nicoya@ubb.ca, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_MK6 = lsof hangs unkillable
Message-Id: <20060120144114.08f0c340.akpm@osdl.org>
In-Reply-To: <20060120203104.GA31803@stusta.de>
References: <6951EFDF-9499-40D5-AD09-2AE217A0A579@ubb.ca>
	<20060120044407.432eae02.akpm@osdl.org>
	<20060120203104.GA31803@stusta.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> On Fri, Jan 20, 2006 at 04:44:07AM -0800, Andrew Morton wrote:
> > Tony Mantler <nicoya@ubb.ca> wrote:
> > >
> > > I'm having trouble running lsof on 2.6.15.1 when the kernel is  
> > > compiled with CONFIG_MK6. When run as root, lsof will segfault, and  
> > > when run as a user lsof will hang unkillable.
> > > 
> > > The same kernel, same machine, but compiled with CONFIG_MK7 runs just  
> > > lsof just fine.
> > 
> > That's creepy.  CONFIG_MK6 hardly does anything.  The main thing it does is
> > feed `-march=k6' into the compiler.  MK7 uses `-march=athlon'.
> >...
> 
> CONFIG_MK7 results in a bigger L1_CACHE_SHIFT than CONFIG_MK6.
> 
> AFAIR it wouldn't be the first time that changing L1_CACHE_SHIFT would 
> hide a real bug visible with a different L1_CACHE_SHIFT.
> 

hm, OK.  Well that's something we can ask Tony to eliminate, by patching
his Kconfig.cpu to make CONFIG_MK6 have the larger L1_CACHE_SHIFT (and/or
vice versa).

