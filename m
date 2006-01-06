Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWAFA23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWAFA23 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWAFA23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:28:29 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:25259 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932315AbWAFA22 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:28:28 -0500
Date: Fri, 6 Jan 2006 00:28:16 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Andrew Morton <akpm@osdl.org>
Cc: Alexander Gran <alex@zodiac.dnsalias.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, len.brown@intel.com, ambx1@neo.rr.com,
       reiserfs-dev@namesys.com, vs@namesys.com,
       Dave Jones <davej@codemonkey.org.uk>,
       "Seth, Rohit" <rohit.seth@intel.com>
Subject: Re: Re. 2.6.15-mm1
In-Reply-To: <20060105162151.6fc1716f.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0601060027060.11451@skynet>
References: <200601051801.29007@zodiac.zodiac.dnsalias.org>
 <20060105144720.25085afa.akpm@osdl.org> <200601060033.34276@zodiac.zodiac.dnsalias.org>
 <20060105162151.6fc1716f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Unable to handle kernel NULL pointer dereference at virtual address 00000020
> >  printing eip:
> > c028b7cf
> > *pde = 372d4067
> > *pte = 00000000
> > Oops: 0000 [#1]
> > PREEMPT
> > last sysfs file: /block/hda/queue/scheduler
> > Modules linked in: aes_i586 cfq_iosched ehci_hcd uhci_hcd
> > CPU:    0
> > EIP:    0060:[<c028b7cf>]    Not tainted VLI
> > EFLAGS: 00013202   (2.6.15-mm1)
> > EIP is at agp_collect_device_status+0x14/0xd4
> > eax: 00000058   ebx: f75c1f08   ecx: 00000000   edx: 00000058
> > esi: 1f000207   edi: c19a80c0   ebp: c19af428   esp: f75c1ed0
> > ds: 007b   es: 007b   ss: 0068
> > Process Xorg (pid: 3843, threadinfo=f75c0000 task=f7890550)
> > Stack: <0>00003246 1f000217 1f000207 1f000217 f75c1f08 1f000207 c19a80c0
> > c19af428
> >        <0>c028b9e9 f75c1f08 00000002 00000000 c19720ec 00000000 1f000217
> > c19af400
> >        <0>00000032 00000001 c028bfb5 c0297262 c19af400 c02972af 1f000207
> > c029727f
> > Call Trace:
> >  [<c028b9e9>] agp_generic_enable+0x72/0x10f
> >  [<c028bfb5>] agp_enable+0xa/0xb
> >  [<c0297262>] drm_agp_enable+0x2c/0x49
> >  [<c02972af>] drm_agp_enable_ioctl+0x30/0x39
> >  [<c029727f>] drm_agp_enable_ioctl+0x0/0x39
> >  [<c029311d>] drm_ioctl+0x93/0x1e4
> >  [<c0163664>] do_ioctl+0x64/0x6d
> >  [<c01637a9>] vfs_ioctl+0x50/0x1be
> >  [<c01ae603>] write_unix_file+0x0/0x500
> >  [<c016394b>] sys_ioctl+0x34/0x51
> >  [<c0102d0f>] sysenter_past_esp+0x54/0x75
> > Code: 02 00 00 00 e8 94 66 f9 ff 89 c6 84 c0 74 de 89 f2 0f b6 c2 5b 5e c3 55
> > 57 56 53 83 ec 10 89 54 24 08 89 4c 24 04 e8 bc ff ff ff <8b> 15 20 00 00 00
> > 8b 1d 10 00 00 0
> > 0 0f b6 c0 8d 48 04 8d 6c 24
> >  <3>[drm:drm_release] *ERROR* Device busy: 1 0
> > EDAC PCI- Detected Parity Error on 0000:00:1e.0
>
> OK.  I've been assuming that this is a DRM bug but I note that the AGP tree
> has been dinking with agp_collect_device_status(), so perhaps I had the wrong
> David.


Nothing in the DRM code in that area has changed enough to cuase that I
don't think... I'd guess AGP problems.. so I'll let DaveJ take a look and
prove its my fault :-)

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

