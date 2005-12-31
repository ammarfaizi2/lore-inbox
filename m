Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965011AbVLaTJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbVLaTJG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 14:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965024AbVLaTJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 14:09:06 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:33811 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965011AbVLaTJF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 14:09:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lFZAaum4mvpVka1S3XGF5pH5XU5tA0N2q+MIW2BQc1D/RVc+3hvE3CrWsnhlikA1NqshoHTy7MSgt2an3VXw6eEquMhEt4FBUjmX9IDbVem6IPHZwzRFFo2DbvF9nGRGxDTQ71+dGHiSdjTA6ObWfkhOFvK4wBc3dpaFyAVC5t8=
Message-ID: <5bdc1c8b0512311109o53f2dd7bva61fde895df68f03@mail.gmail.com>
Date: Sat, 31 Dec 2005 11:09:04 -0800
From: Mark Knecht <markknecht@gmail.com>
To: Bradley Reed <bradreed1@gmail.com>
Subject: Re: MPlayer broken under 2.6.15-rc7-rt1?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051231201808.43d6c4d6@galactus.example.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051231201808.43d6c4d6@galactus.example.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/31/05, Bradley Reed <bradreed1@gmail.com> wrote:
> I have tried MPlayer versions 1.0pre6, 1.0pre7, and cvs from today and
> they all work fine under 2.6.14 and 2.6.14-rt21/22.
>
> I booted into 2.6.15-rc7-rt1 and the same MPlayer binaries segfault on
> every video I try and play. Yes, I have nvidia modules loaded, so won't
> get much help, but thought someone might like to know.
>
> xine plays the videos fine.
>
> BTW, other than MPLayer problems, everything else works great.
>
> Brad

Hi,
   Strange results here. I tried mplayer playing both audio only and
then some video recorded with MythTV. No segfault problems with either
one on my end but on the video (Tonight Show) the audio was very
clearly out of sync with the video.

   To check it out further I tried watching the same clip in MythTV
and got a crash:

----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at include/linux/timer.h:83
invalid operand: 0000 [1] PREEMPT
CPU 0
Modules linked in: snd_seq_midi snd_pcm_oss snd_mixer_oss snd_seq_oss
snd_seq_mi di_event snd_seq realtime sbp2 ohci1394 ieee1394 snd_hdsp
snd_rawmidi snd_seq_de vice snd_hwdep snd_intel8x0 snd_ac97_codec
snd_ac97_bus snd_pcm snd_timer snd sn d_page_alloc radeon drm
Pid: 8553, comm: mythfrontend Not tainted 2.6.15-rc7-rt1 #1
RIP: 0010:[<ffffffff802ae2fa>] <ffffffff802ae2fa>{rtc_do_ioctl+730}
RSP: 0018:ffff81000adb9e08  EFLAGS: 00210282
RAX: 0000000000000000 RBX: 0000000000200202 RCX: ffff81001f9217c0
RDX: 0000000000000000 RSI: ffff81000a6d5030 RDI: ffff81001f9217c0
RBP: 0000000000000001 R08: ffff81000adb8000 R09: 0000000000000001
R10: 00002aaaaaac0660 R11: 0000000000200246 R12: 00000000fffffff3
R13: 0000000000007005 R14: 0000000000000013 R15: 00002aaaab3d3850
FS:  0000000043005960(0063) GS:ffffffff80573800(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaac987620 CR3: 00000000063a9000 CR4: 00000000000006e0
Process mythfrontend (pid: 8553, threadinfo ffff81000adb8000, task
ffff81000a6d5 030)
Stack: ffff81001e986bc8 0000000000200246 0000000000200202 0000000000200246
       ffff81001ffa13c0 ffffffff80181331 0000000000008000 0000000000008000
       ffff81000adc56c0 ffff81001e986bc8
Call Trace:<ffffffff80181331>{chrdev_open+449} <ffffffff80181170>{chrdev_open+0}
       <ffffffff801771fc>{__dentry_open+332} <ffffffff804051da>{lock_kernel+42}
       <ffffffff8018b4e4>{do_ioctl+116} <ffffffff8018b7c2>{vfs_ioctl+690}
       <ffffffff8018b85a>{sys_ioctl+106} <ffffffff8010dba6>{system_call+126}


Code: 0f 0b 68 9d 5f 42 80 c2 53 00 48 8b 35 25 54 2a 00 48 c7 c7
RIP <ffffffff802ae2fa>{rtc_do_ioctl+730} RSP <ffff81000adb9e08>

mark@lightning ~ $


* media-video/mplayer
     Available versions:  1.0_pre7-r1
     Installed:           1.0_pre7-r1


mark@lightning ~ $ eix mythtv
* media-tv/mythtv
     Available versions:  0.18.1-r1 ~0.18.1-r2 [M]0.18.2_pre7882
     Installed:           0.18.1-r1

lightning ~ # emerge info
Portage 2.0.53 (default-linux/amd64/2005.1, gcc-3.4.4, glibc-2.3.5-r2,
2.6.15-rc7-rt1 x86_64)
=================================================================
System uname: 2.6.15-rc7-rt1 x86_64 AMD Athlon(tm) 64 Processor 3000+
Gentoo Base System version 1.6.13
dev-lang/python:     2.3.5-r2, 2.4.2
sys-apps/sandbox:    1.2.12
sys-devel/autoconf:  2.13, 2.59-r6
sys-devel/automake:  1.4_p6, 1.5, 1.6.3, 1.7.9-r1, 1.8.5-r3, 1.9.6-r1
sys-devel/binutils:  2.16.1
sys-devel/libtool:   1.5.20
virtual/os-headers:  2.6.11-r2
ACCEPT_KEYWORDS="amd64"

   Looks like there is a bit of an issue here.

- Mark
