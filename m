Return-Path: <linux-kernel-owner+w=401wt.eu-S964894AbWL1Cl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbWL1Cl2 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 21:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbWL1Cl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 21:41:28 -0500
Received: from mga05.intel.com ([192.55.52.89]:37379 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964897AbWL1Cl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 21:41:27 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,213,1165219200"; 
   d="scan'208"; a="182302616:sNHT26819975"
Subject: Re: Oops in 2.6.19.1
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Chuck Ebbert <76306.1226@compuserve.com>
In-Reply-To: <200612271235.08845.s0348365@sms.ed.ac.uk>
References: <200612201421.03514.s0348365@sms.ed.ac.uk>
	 <200612231540.47176.s0348365@sms.ed.ac.uk>
	 <1167185232.15989.129.camel@ymzhang>
	 <200612271235.08845.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=utf-8
Date: Thu, 28 Dec 2006 10:41:34 +0800
Message-Id: <1167273694.15989.146.camel@ymzhang>
Mime-Version: 1.0
X-Mailer: Evolution 2.9.2 (2.9.2-2.fc7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-27 at 12:35 +0000, Alistair John Strachan wrote:
> On Wednesday 27 December 2006 02:07, Zhang, Yanmin wrote:
> [snip]
> > > 00000000 Call Trace:
> > >  [<c015d7f3>] do_sys_poll+0x253/0x480
> > >  [<c015da53>] sys_poll+0x33/0x50
> > >  [<c0102c97>] syscall_call+0x7/0xb
> > >  [<b7f26402>] 0xb7f26402
> > >  =======================
> > > Code: 58 01 00 00 0f 4f c2 09 c1 89 c8 83 c8 08 85 db 0f 44 c8 8b 5d f4
> > > 89 c8 8b 75
> > > f8 8b 7d fc 89 ec 5d c3 89 ca 8b 46 6c 83 ca 10 3b <87> 68 01 00 00 0f 45
> > > ca eb b6 8d b6 00 00 00 00 55 b8 01 00 00
> >
> > Above codes look weird. Could you disassemble kernel image and post
> > the part around address 0xc0156f60?
> >
> > "87 68 01 00 00" is instruction xchg, but if I disassemble from the
> > begining, I couldn't see instruct xchg.
> >
> > > EIP: [<c0156f60>] pipe_poll+0xa0/0xb0 SS:ESP 0068:ee1b9c0c
> 
> Unfortunately, after suspecting the toolchain, I did a manual rebuild of 
> binutils, gcc and glibc from the official sites, and then rebuilt 2.6.19.1. 
> This might upset the decompile below, versus the original report.
> 
> Assuming it's NOT a bug in my distro's toolchain (because I am now running the 
> GNU stuff), it'll crash again, so this is still useful.
> 
> Here's a current decompilation of vmlinux/pipe_poll() from the running kernel, 
> the addresses have changed slightly. There's no xchg there either:
Could you reproduce the bug by the new kernel, so we could get the exact address
and instruction of the bug?
