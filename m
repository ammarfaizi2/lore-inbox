Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbVCJGFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVCJGFg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 01:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbVCIUco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 15:32:44 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:64279 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262188AbVCIUMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 15:12:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=ZpM61umOKaa7ydF+0/ZPfMkxi/tfeiPv1OCOPTtrtMGxjUNQaN6lZfbqP+ZJMLZjp1xxkpvXnxw6lhYOdSAqPz68YKJXcPTRRqS6t6aBdDf+UjEVSbYGYbKa4EmXJIzqPsKp+NohAIcpZtqSK++DnYLViKGITWuVS7Usq2wGVlo=
Message-ID: <493984f050309121212541d8@mail.gmail.com>
Date: Wed, 9 Mar 2005 21:12:51 +0100
From: Christian Henz <christian.henz@gmail.com>
Reply-To: Christian Henz <christian.henz@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.11-mm2 + Radeon crash
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I wanted to try 2.6.11-mm2 for the low latency/realtime lsm stuff and
I've run into a severe
problem.

When I try to start X, my machine reboots. The screen goes dark as
usual when setting the video mode, but then I get a beep and I'm
greeted with the BIOS boot messages. This happened 4/5 times i've
tried, and once the video mode was actually set (at least I saw the
usual X b/w pattern with some random framebuffer garbage), the machine
didn't reboot but after that nothing happened. My keyboard was still
responsive (ie NumLock LED would still go on/off), but i could neither
kill X with CTRL-ALT-BACKSPACE nor could i switch back to console, so
I ended up pressing reset.

After the crashes I booted with a rescue CD to examine the logs, but I
could not find any obvious errors.

Everything works nicely on 2.6.10 and earlier kernels. I'm in the
process of building 2.6.11.2 to see if the crash occurs there.

Here is some info on my system:

I've got an Athlon 1000C on a VIA KT133 chipset and a Radeon 7200 (the
original Radeon with 32MB SDR RAM). I'm running Debian/sid.


homer:/home/chrissi# X -version
X: warning; /dev/dri has unusual mode (not 755) or is not a directory.
XFree86 Version 4.3.0.1 (Debian 4.3.0.dfsg.1-12.0.1 20050223080930
joshk@triplehelix.org)
Release Date: 15 August 2003
X Protocol Version 11, Revision 0, Release 6.6
Build Operating System: Linux 2.6.9 i686 [ELF]
Build Date: 23 February 2005


lspci -vv says bout the Radeon:


0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon
R100 QD [Radeon 7200] (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Radeon 7000/Radeon
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
        Region 1: I/O ports at c000 [size=256]
        Region 2: Memory at d7000000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit-
FW- Rate=<none>
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-



Please let me know what more data is needed to figure this one out.

Thanks,
Christian Henz

PS: If you reply, please CC me as I'm not subscribed.
