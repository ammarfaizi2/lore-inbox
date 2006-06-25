Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWFYMS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWFYMS6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 08:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWFYMS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 08:18:58 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:40815 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750737AbWFYMS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 08:18:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WMnIXbDJc45NajgGgfbkclUx61M1zdHMOKDTDm/AQ+TG0gO3FbRv9i0EUb1bjWcmfJGiaiwuvJQnlraGTI575GlHTtxx+VC335BVViY2wq9DNd+4m+uYTsSMZMJaaF3LZlUiu7LgUONoMT3GlRjoyJ5OVSY1U4rLt0eAUfZqT54=
Message-ID: <6bffcb0e0606250518t1a6ba70cgc92d6353139a4ead@mail.gmail.com>
Date: Sun, 25 Jun 2006 14:18:56 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-mm2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060625044013.09190fff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060624061914.202fbfb5.akpm@osdl.org>
	 <6bffcb0e0606250419p5e1fca1en5975f3d7a3c12ecd@mail.gmail.com>
	 <20060625044013.09190fff.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/06, Andrew Morton <akpm@osdl.org> wrote:
> On Sun, 25 Jun 2006 13:19:25 +0200
> "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:
>
> > On 24/06/06, Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm2/
> > >
> >
> > I found this in /var/log/messages.1
> >
> > Jun 24 22:29:52 ltg01-fedora kernel: BUG: unable to handle kernel
> > paging request at virtual address 6b6b6b7b
> > Jun 24 22:29:52 ltg01-fedora kernel:  printing eip:
> > Jun 24 22:29:52 ltg01-fedora kernel: c01174f2
> > Jun 24 22:29:52 ltg01-fedora kernel: *pde = 00000000
> > Jun 24 22:29:52 ltg01-fedora kernel: Oops: 0000 [#1]
> > Jun 24 22:29:52 ltg01-fedora kernel: 4K_STACKS PREEMPT SMP
> > Jun 24 22:29:52 ltg01-fedora kernel: last sysfs file:
> > /devices/platform/i2c-9191/9191-0290/temp2_input
> > Jun 24 22:29:52 ltg01-fedora kernel: Modules linked in: ipv6 w83627hf
> > hwmon_vid hwmon i2c_isa af_packet ip_conntrack_netbios
> > _ns ipt_REJECT xt_state ip_conntrack nfnetlink xt_tcpudp
> > iptable_filter ip_tables x_tables p4_clockmod speedstep_lib binfmt_
> > misc thermal processor fan container parport_pc parport nvram
> > snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq
> > _oss snd_seq_midi_event evdev snd_seq snd_seq_device snd_pcm_oss
> > snd_mixer_oss snd_pcm snd_timer snd soundcore ide_cd snd_pa
> > ge_alloc intel_agp i2c_i801 sk98lin skge agpgart cdrom rtc unix
> > Jun 24 22:29:52 ltg01-fedora kernel: CPU:    0
> > Jun 24 22:29:52 ltg01-fedora kernel: EIP:    0060:[<c01174f2>]    Not
> > tainted VLI
> > Jun 24 22:29:52 ltg01-fedora kernel: EFLAGS: 00010096   (2.6.17-mm2 #51)
> > Jun 24 22:29:52 ltg01-fedora kernel: EIP is at task_rq_lock+0x1d/0x57
>
> OK, thanks.  I expect the below will fix that (I've since dropped the
> offending patches)
>

Problem fixed, thanks.

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
