Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbUEXIAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbUEXIAN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 04:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263340AbUEXIAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 04:00:12 -0400
Received: from web90002.mail.scd.yahoo.com ([66.218.94.60]:21949 "HELO
	web90002.mail.scd.yahoo.com") by vger.kernel.org with SMTP
	id S261988AbUEXIAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 04:00:04 -0400
Message-ID: <20040524080001.33595.qmail@web90002.mail.scd.yahoo.com>
Date: Mon, 24 May 2004 01:00:01 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: Re: Help understanding slow down
To: Andrew Morton <akpm@osdl.org>
Cc: wli@holomorphy.com, jakob@unthought.net, linux-kernel@vger.kernel.org
In-Reply-To: <20040524005331.71465614.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

I have turned HT off in the bios (caused non
deterministic performance) and I did not configure the
kernel for SMT.  Additionally, looking at dmesg shows
no idle-poll (and I do not boot the kernel with
idle-poll).  
Should I post my config for this kernel?

Thank you for your time.
Phy
--- Andrew Morton <akpm@osdl.org> wrote:
> Phy Prabab <phyprabab@yahoo.com> wrote:
> >
> > Okay, here is the output:
> > 
> >  317955 total                                     
> >  0.1302
> >  263633 poll_idle                               
> >  4545.3966
> >    6764 do_page_fault                             
> >  5.1951
> >    3650 kmap_atomic 
> 
> It's strange that you appear to be using
> poll_idle().  Maybe it's an error
> in the profiler - it sometimes makes mistakes in
> identifying small
> functions.
> 
> But if you _are_ using poll_idle() and if your CPU
> is hyperthreaded then
> yes, one "CPU" is going to take a performance hit
> from the "idle" one.
> 
> Is your CPU hyperthreaded?  (cat /proc/cpuinfo)
> 
> Are you booting with "idle=poll"?  Do `dmesg -s
> 1000000 | grep idle'.
> 


	
		
__________________________________
Do you Yahoo!?
Yahoo! Domains – Claim yours for only $14.70/year
http://smallbusiness.promotions.yahoo.com/offer 
