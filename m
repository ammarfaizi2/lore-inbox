Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131352AbRCUMrY>; Wed, 21 Mar 2001 07:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131376AbRCUMrP>; Wed, 21 Mar 2001 07:47:15 -0500
Received: from vortex.physik.uni-konstanz.de ([134.34.143.44]:53774 "EHLO
	vortex.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id <S131352AbRCUMq7>; Wed, 21 Mar 2001 07:46:59 -0500
Message-Id: <200103211246.f2LCk7o01634@vortex.physik.uni-konstanz.de>
From: max <865news6854@vortex.physik.uni-konstanz.de>
Subject: 2.4.2 SIGTRAP mystery
To: linux-kernel@vger.kernel.org
Date: Wed, 21 Mar 2001 13:46:07 +0100
User-Agent: KNode/0.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

in our workgroup we run simulation jobs that may take a few days at a time 
to complete. Since recently, after upgrading some boxen to 2.4.2, we have 
jobs flaking out with messages like

Trace/Breakpoint trap

without core dumps. Unfortunately this happens unpredictably but 
consistently after several hours. The same binaries run on (identical) 
other machines (with 2.2.x) without problems. There is definitely no 
debugger interference as one might think seeing these messages. Also, 
hardware//overheating problems can be ruled out.

Digging around in lkml archives, I found this old (Jun 23 2000) post 
concerning "2.4.0-test2-11"
>ok, things are starting to get really odd on 2.4.0-test2-11 now.
># tar xzf storage/glibc-2.1.3.tar.gz
># tar tzf storage/glibc-linuxthreads-2.1.3.tar.gz
>Trace/breakpoint trap 
># tar tzf storage/glibc-linuxthreads-2.1.3.tar.gz 
>Trace/breakpoint trap 
># strace -f tar tzf storage/glibc-linuxthreads-2.1.3.tar.gz 
>Trace/breakpoint trap 
># ltrace -s 256 -S -f tar tzf storage/glibc-linuxthreads-2.1.3.tar.gz 
>Trace/breakpoint trap 
># ls 
>Trace/breakpoint trap 
># pwd 
>/usr/src 
># whoami 
>Trace/breakpoint trap 
># dmesg 
>Trace/breakpoint trap 

This is extreme compared to our little problem, but perhaps there is a 
connection? Please enlighten me if anybody knows what is going on. Or give 
me a hint on how to go about debugging this myself.

Regards
Max
