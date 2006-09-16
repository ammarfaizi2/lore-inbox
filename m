Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbWIPOKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWIPOKd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 10:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWIPOKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 10:10:33 -0400
Received: from novell.stoldgods.nu ([83.150.147.20]:27829 "EHLO
	novell.stoldgods.nu") by vger.kernel.org with ESMTP
	id S1751442AbWIPOKc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 10:10:32 -0400
From: Magnus =?iso-8859-1?q?M=E4=E4tt=E4?= <novell@kiruna.se>
To: Neil Brown <neilb@suse.de>
Subject: Re: 2.6.18-rc6-mm1
Date: Sat, 16 Sep 2006 16:10:22 +0200
User-Agent: KMail/1.9.4
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200609091445.32744.novell@kiruna.se> <20060909112724.a214197b.akpm@osdl.org> <17671.36613.134163.171162@cse.unsw.edu.au>
In-Reply-To: <17671.36613.134163.171162@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609161610.23160.novell@kiruna.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry for the late reply, been away a few days.

On Wednesday 13 September 2006 06:54, Neil Brown wrote:
> On Saturday September 9, akpm@osdl.org wrote:
> > On Sat, 9 Sep 2006 14:45:32 +0200
> > Magnus M‰‰tt‰ <novell@kiruna.se> wrote:
> > > [15164.017991] RPC request reserved 9136 but used 9268
> > > [15164.037431] RPC request reserved 9136 but used 9268
> > > [15164.052988] RPC request reserved 9136 but used 9268
> > > 
> 
> Don't know what is causing this yet....
> 
> > > Using defaults from ksymoops -t elf32-i386 -a i386
> > > EFLAGS: 00210212   (2.6.18-rc6-mm1 #1)
> > > eax: 00000000   ebx: e5299000   ecx: 00000000   edx: e8843620
> ..
> > >  [<c02784ba>] nfsd+0x18a/0x2b0
> > >  [<c0103fb7>] kernel_thread_helper+0x7/0x10
> > > Code: 89 45 e8 8b 52 28 83 c6 70 89 55 e4 8b 40 04 83 f8 17 0f 86 6d 
> > > 04 00 00 8b 5d 08 8b 83 9c 04 00 00 c7 83 a0 04 00 00 01 00 00 00 
> > > <8b> 00 89 04 24 e8 06 d4 ca ff c7 46 04 00 00 00 00 89 c1 89 43
> > > 
> > > 
> > > >>EIP; c04ad300 <svc_process+40/6a0>   <=====
> 
> But this is probably fixed by the following patch.
> Can you confirm?

Yes, the patch fixed it, thanks!


Regards,
Magnus
