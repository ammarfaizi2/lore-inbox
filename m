Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263158AbTJKAYm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 20:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263172AbTJKAYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 20:24:42 -0400
Received: from maintech.de ([217.160.75.157]:407 "EHLO p10065214.pureserver.de")
	by vger.kernel.org with ESMTP id S263158AbTJKAYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 20:24:40 -0400
Message-ID: <3F874DC6.7090404@maintech.de>
Date: Sat, 11 Oct 2003 02:24:38 +0200
From: Thomas Kleffel <lkml@maintech.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030813 Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bug report for linux-2.6.0-test7: System crashes when I try to start
 my software raid
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Today I wanted to give 2.6.0 a try on my fileserver. It's got a software 
raid (md - no evms) with 11*120GB IDE. When I tried to start it 
(raidstart /dev/md0) my system crashed badly. It didnt react to anything 
but magic sysreq. The last thing I could see was an (incomplete) stack 
trace. Incomplete beacause scrollback didn't work anymore. It looks like 
the crashes didn't trash my data or raid headers.

I can reproduce the bug - it happens everytime when I try to start my raid.
I already tried to disable DMA - didn't help. The system worked fine for 
over a year with 2.4.x kernels. Currently I run 2.4.22_pre2-gss (a 
gentoo flavour).

I am willing to help anyone who wants to fix this as good as I can. This 
includes giving informations,  testing, etc... just contact me.

If there's a better place than this list for posting this report, please 
tell me.

Thanks for helping,
Thomas Kleffel


Some information that might be helpful:

lspci:
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] 
(rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] 
(rev 40)
00:04.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
00:04.3 USB Controller: VIA Technologies, Inc. USB (rev 16)
00:04.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:09.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] 
(rev 78)
00:0a.0 Unknown mass storage controller: Triones Technologies, Inc. 
HPT366/368/370/370A/372 (rev 03)
00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265 
(rev 02)
01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo Banshee 
(rev 03)


cpuinfo:
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1109.910
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca 
cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2215.11



