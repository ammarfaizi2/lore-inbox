Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315746AbSHaCtq>; Fri, 30 Aug 2002 22:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315779AbSHaCtq>; Fri, 30 Aug 2002 22:49:46 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:38405
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S315746AbSHaCtp>; Fri, 30 Aug 2002 22:49:45 -0400
Date: Fri, 30 Aug 2002 19:54:00 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Allan Duncan <allan.d@bigpond.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       faith@valinux.com
Subject: Re: Linux 2.4.20-pre4 blows away Xwindows with Matrox G400 and DRM
Message-ID: <20020831025400.GA457@matchmail.com>
Mail-Followup-To: Allan Duncan <allan.d@bigpond.com>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	faith@valinux.com
References: <3D621BF8.F1242760@bigpond.com> <3D677F5B.7AD0D472@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D677F5B.7AD0D472@bigpond.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 24, 2002 at 10:43:07PM +1000, Allan Duncan wrote:
> I have done some more digging, including the same kernel on a second host.
> The second box has a K6, VIA MVP3 chipset, and a G200 with 8M, otherwise
> the software versions are the same.  It works fine.  Taking the .config
> used for that, I redid the kernel on the AthlonXP / VIA KT266a / G400,
> almost instant reboot.
> 
> 
> One of the crashes was a touch later, and the last few lines from
> /var/log/messages was:
> Aug 21 20:46:32 localhost login(pam_unix)[1063]: session opened for user alland by LOGIN(uid=0)
> Aug 21 20:46:32 localhost  -- alland[1063]: LOGIN ON tty1 BY alland
> Aug 21 20:50:22 localhost modprobe: modprobe: Can't locate module char-major-226
> Aug 21 20:50:22 localhost modprobe: modprobe: Can't locate module char-major-226
> Aug 21 20:50:22 localhost kernel: Linux agpgart interface v0.99 (c) Jeff Hartmann
> Aug 21 20:50:22 localhost kernel: agpgart: Maximum main memory to use for agp memory: 439M
> Aug 21 20:50:22 localhost kernel: agpgart: Detected Via Apollo Pro KT266 chipset
> Aug 21 20:50:22 localhost kernel: agpgart: AGP aperture is 128M @ 0xd0000000
> Aug 21 20:50:22 localhost kernel: [drm] AGP 0.99 on VIA Apollo KT133 @ 0xd0000000 128MB
> Aug 21 20:50:22 localhost kernel: [drm] Initialized mga 3.0.2 20010321 on minor 0
> Aug 21 20:57:29 localhost syslogd 1.4.1: restart.
> 
> The "char-major-226" corresponds to the /dev/dri/card0 above, and the failure point
> seems to be when the drmOpenDevice succeeds on the third attempt.
> 
> I tried unsetting CONFIG_DRM, but it still fails.

I have seen something similar on 2.4.19-pre8-aa3, but I haven't tried to
debug the setup.  I did a hardware reset (software reset would just reboot
after X started again) and was able to avoid the problem.  A few days later
I upgraded it to 2.4.19.  I haven't seen the problem since then, but it has
only been a few days.

00:00.0 Host bridge: Intel Corp. 82820 820 (Camino) Chipset Host Bridge
(MCH) (rev 03)
00:01.0 PCI bridge: Intel Corp. 82820 820 (Camino) Chipset PCI to AGP Bridge
(rev 03)
00:1e.0 PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 02)
00:1f.0 ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801AA IDE (rev 02)
00:1f.2 USB Controller: Intel Corp. 82801AA USB (rev 02)
00:1f.3 SMBus: Intel Corp. 82801AA SMBus (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801AA AC'97 Audio (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation Riva TnT2 [NV5] (rev 11)

Mike
