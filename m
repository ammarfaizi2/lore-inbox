Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293632AbSEALIk>; Wed, 1 May 2002 07:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293680AbSEALIj>; Wed, 1 May 2002 07:08:39 -0400
Received: from ep09.kernel.pl ([212.87.11.162]:55627 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id <S293632AbSEALIj>;
	Wed, 1 May 2002 07:08:39 -0400
Date: Wed, 1 May 2002 13:08:35 +0200 (CEST)
From: Witek Krecicki <adasi@kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: [BUG] Hangs on 2.5.11 
Message-ID: <Pine.LNX.4.44.0205011307580.30497-100000@ep09.kernel.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to run poldek (rpm-updater from PLD distro) it's hanging 
without any reason. It's impossible to kill it, even with SIGKILL. Also ps 
uax is hanging just before poldek process. Also trying to read anything in 
/proc/{poldek-pid} makes 'cat' process hangs. SAK sequence is clearing 
console, but processes are still hanging. GDB didn't said anything (it 
hanged), but strace shows this:
<cut>
mremap(0x407c5000, 8192, 12288, MREMAP_MAYMOVE) = 0x407c1000
brk(0x82e5000)                          = 0x82e5000
brk(0x82e6000)                          = 0x82e6000
old_mmap(NULL, 135168, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 
-1, 0) = 0x407dc000
mremap(0x407ce000, 8192, 12288, MREMAP_MAYMOVE
</cut>
And hangs... What's the reason of it?
Witek 'adasi' Krecicki


