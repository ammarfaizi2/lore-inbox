Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423009AbWJSRSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423009AbWJSRSL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 13:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423016AbWJSRSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 13:18:11 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:18915 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S1423009AbWJSRSI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 13:18:08 -0400
Date: Thu, 19 Oct 2006 10:17:27 -0700
To: Andrew Morton <akpm@osdl.org>
Cc: Mariusz Kozlowski <m.kozlowski@tuxland.pl>, linux-kernel@vger.kernel.org,
       "John W. Linville" <linville@tuxdriver.com>
Subject: Re: 2.6.19-rc2-mm1 // errors in verify_redzone_free()
Message-ID: <20061019171727.GA9350@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20061016230645.fed53c5b.akpm@osdl.org> <200610191645.40308.m.kozlowski@tuxland.pl> <20061019100342.4e4895fb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061019100342.4e4895fb.akpm@osdl.org>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 10:03:42AM -0700, Andrew Morton wrote:
> On Thu, 19 Oct 2006 16:45:39 +0200
> Mariusz Kozlowski <m.kozlowski@tuxland.pl> wrote:
> 
> > Hello,
> > 
> > 	Multiple of verif were found with 2.6.19-rc2-mm1 kernel:
> > 
> > slab error in verify_redzone_free(): cache `size-32': memory outside object 
> > was overwritten
> >  [<c0103765>] dump_trace+0x1c1/0x1f1
> >  [<c01037af>] show_trace_log_lvl+0x1a/0x30
> >  [<c0103ed8>] show_trace+0x12/0x14
> >  [<c0103f7b>] dump_stack+0x19/0x1b
> >  [<c0158357>] __slab_error+0x26/0x28
> >  [<c0158496>] cache_free_debugcheck+0x13d/0x1d8
> >  [<c0158bb0>] kfree+0x54/0xa5
> >  [<c037fba4>] ioctl_standard_call+0x187/0x2a1
> >  [<c037ffe6>] wireless_process_ioctl+0x328/0x3c7
> >  [<c03763d4>] dev_ioctl+0x1fd/0x372
> >  [<c036b080>] sock_ioctl+0x34/0x1e8
> >  [<c0167a92>] do_ioctl+0x22/0x71
> >  [<c0167b36>] vfs_ioctl+0x55/0x29b
> >  [<c0167daf>] sys_ioctl+0x33/0x50
> >  [<c0102ff5>] sysenter_past_esp+0x56/0x79
> >  [<b7f4e410>] 0xb7f4e410
> >  =======================
> > dd20cb64: redzone 1:0x170fc2a5, redzone 2:0x170fc200.
> > slab error in verify_redzone_free(): cache `size-32': memory outside object 
> > was overwritten
> >  [<c0103765>] dump_trace+0x1c1/0x1f1
> >  [<c01037af>] show_trace_log_lvl+0x1a/0x30
> >  [<c0103ed8>] show_trace+0x12/0x14
> >  [<c0103f7b>] dump_stack+0x19/0x1b
> >  [<c0158357>] __slab_error+0x26/0x28
> >  [<c0158496>] cache_free_debugcheck+0x13d/0x1d8
> >  [<c0158bb0>] kfree+0x54/0xa5
> >  [<c037fba4>] ioctl_standard_call+0x187/0x2a1
> >  [<c037ffe6>] wireless_process_ioctl+0x328/0x3c7
> >  [<c03763d4>] dev_ioctl+0x1fd/0x372
> >  [<c036b080>] sock_ioctl+0x34/0x1e8
> >  [<c0167a92>] do_ioctl+0x22/0x71
> >  [<c0167b36>] vfs_ioctl+0x55/0x29b
> >  [<c0167daf>] sys_ioctl+0x33/0x50 
> >  [<c0102ff5>] sysenter_past_esp+0x56/0x79
> >  [<b7f4e410>] 0xb7f4e410
> 
> The wireless ioctls are still blowing up?  I thought we'd fixed that,
> or is this something new?

	Do you know which driver the user is using ? Is it an
in-kernel driver, or an out-of-kernel driver ?
	Thanks !

	Jean
