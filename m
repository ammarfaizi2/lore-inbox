Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262921AbVGHWDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262921AbVGHWDR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 18:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262901AbVGHWAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 18:00:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:20375 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262829AbVGHV7v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 17:59:51 -0400
Date: Fri, 8 Jul 2005 14:55:18 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: nboyle@tampabay.rr.com, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Oops: EIP is at sysfs_release+0x34/0x80
Message-ID: <20050708215518.GB21768@kroah.com>
References: <42CEB851.1000004@tampabay.rr.com> <20050708145001.34b9f8f2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050708145001.34b9f8f2.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2005 at 02:50:01PM -0700, Andrew Morton wrote:
> Nathan Boyle <nboyle@tampabay.rr.com> wrote:
> >
> > EIP is at sysfs_release+0x34/0x80
> > eax: 00000001   ebx: dc7c2000   ecx: d1979860   edx: 00000001
> > esi: 762f7373   edi: d5ba26a0   ebp: d9368544   esp: dc7c3f80
> > ds: 007b   es: 007b   ss: 0068
> > Process udev (pid: 31802, threadinfo=dc7c2000 task=c7c19040)
> > Stack: df468c40 df798140 dffe4140 c0153c08 d5a9edbc df468c40 df798140
> > 00000000
> >         dc7c2000 c01523d3 00000000 00000003 080ac568 00000003 c0103101
> > 00000003
> >         080ac568 00000004 080ac568 00000003 08057198 00000006 0000007b
> > 0000007b
> > Call Trace:
> >   [<c0153c08>] __fput+0xf8/0x110
> >   [<c01523d3>] filp_close+0x43/0x70
> >   [<c0103101>] syscall_call+0x7/0xb
> > Code: 8b 41 0c 8b 40 48 8b 58 14 8b 41 48 8b 40 14 85 db 8b 70 04 74 07
> > 89 d8 e8 9a 11 02 00 85 f6 74 1f bb 00 e0 ff ff 21 e3 ff 43 14 <ff> 8e
> > 00 01 00 00 83 3e 02 74 32 8b 43 08 ff 4b 14 a8 08 75 21
> >   <6>note: udev[31802] exited with preempt_count 1
> 
> Gee we get a lot of these, and no idea which sysfs file caused it.
> 
> How about we record the most-recently-opened sysfs file and display that at
> oops time?  (-mm only)

Looks good to me, I really have no idea of what is causing this, and
haven't seen any reports of this on mainline.

thanks,

greg k-h
