Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262207AbVCUXub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262207AbVCUXub (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 18:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbVCUXsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 18:48:11 -0500
Received: from fire.osdl.org ([65.172.181.4]:63199 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262169AbVCUXnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 18:43:32 -0500
Date: Mon, 21 Mar 2005 15:43:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christian Henz <christian.henz@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm2 + Radeon crash
Message-Id: <20050321154332.0ca3e153.akpm@osdl.org>
In-Reply-To: <493984f050309121212541d8@mail.gmail.com>
References: <493984f050309121212541d8@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Henz <christian.henz@gmail.com> wrote:
>
> Hi, 
> 
> I wanted to try 2.6.11-mm2 for the low latency/realtime lsm stuff and
> I've run into a severe
> problem.

Christian, some fixes have bene made in this area.  Could you please test
2.6.12-rc1-mm1?


> When I try to start X, my machine reboots. The screen goes dark as
> usual when setting the video mode, but then I get a beep and I'm
> greeted with the BIOS boot messages. This happened 4/5 times i've
> tried, and once the video mode was actually set (at least I saw the
> usual X b/w pattern with some random framebuffer garbage), the machine
> didn't reboot but after that nothing happened. My keyboard was still
> responsive (ie NumLock LED would still go on/off), but i could neither
> kill X with CTRL-ALT-BACKSPACE nor could i switch back to console, so
> I ended up pressing reset.
> 
> After the crashes I booted with a rescue CD to examine the logs, but I
> could not find any obvious errors.
> 
> Everything works nicely on 2.6.10 and earlier kernels. I'm in the
> process of building 2.6.11.2 to see if the crash occurs there.
> 
> Here is some info on my system:
> 
> I've got an Athlon 1000C on a VIA KT133 chipset and a Radeon 7200 (the
> original Radeon with 32MB SDR RAM). I'm running Debian/sid.
> 
> 
> homer:/home/chrissi# X -version
> X: warning; /dev/dri has unusual mode (not 755) or is not a directory.
> XFree86 Version 4.3.0.1 (Debian 4.3.0.dfsg.1-12.0.1 20050223080930
> joshk@triplehelix.org)
> Release Date: 15 August 2003
> X Protocol Version 11, Revision 0, Release 6.6
> Build Operating System: Linux 2.6.9 i686 [ELF]
> Build Date: 23 February 2005
> 
> 
> lspci -vv says bout the Radeon:
> 
> 
> 0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon
> R100 QD [Radeon 7200] (prog-if 00 [VGA])
>         Subsystem: ATI Technologies Inc Radeon 7000/Radeon
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping+ SERR- FastB2B-
>         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (2000ns min), Cache Line Size: 0x08 (32 bytes)
>         Interrupt: pin A routed to IRQ 5
>         Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
>         Region 1: I/O ports at c000 [size=256]
>         Region 2: Memory at d7000000 (32-bit, non-prefetchable) [size=512K]
>         Capabilities: [58] AGP version 2.0
>                 Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
> HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
>                 Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit-
> FW- Rate=<none>
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 
> 
> Please let me know what more data is needed to figure this one out.
> 
> Thanks,
> Christian Henz
> 
> PS: If you reply, please CC me as I'm not subscribed.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
