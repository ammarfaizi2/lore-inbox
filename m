Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281628AbRKMOHb>; Tue, 13 Nov 2001 09:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281627AbRKMOHW>; Tue, 13 Nov 2001 09:07:22 -0500
Received: from AGrenoble-101-1-4-53.abo.wanadoo.fr ([217.128.202.53]:20865
	"EHLO strider.virtualdomain.net") by vger.kernel.org with ESMTP
	id <S279588AbRKMOHM> convert rfc822-to-8bit; Tue, 13 Nov 2001 09:07:12 -0500
Message-ID: <3BF08E07.3010003@wanadoo.fr>
Date: Tue, 13 Nov 2001 04:05:43 +0100
From: =?ISO-8859-15?Q?Fran=E7ois?= Cami <stilgar2k@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us, fr
MIME-Version: 1.0
To: bredroll@atari.org
Cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Kernel 2.4.14 compile fail (block.o)
In-Reply-To: <20011112160632.A11922@earth.dsh.org.uk>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Known bug - patch is in 2.4.15pre1
Beware, in pre1 and pre2 netfilter (iptables)
doesn't work.

François


Ian Norton wrote:

> Hi :-), 
> 
> -- One Liner: make dep is fine but block.o fails to compile
> 
> --Problem: 
> Make menuconfig for a pretty standard kernel, set for no driver modules, make
> bzImage fails at block.o,
> 
> # drivers/block/block.o: In function `lo_send':
> # drivers/block/block.o(.text+0x895f): undefined reference to `deactivate_page'
> # drivers/block/block.o(.text+0x89a9): undefined reference to `deactivate_page'
> 
> The currently running system is going along just fine with 2.4.2 no problems
> at all, good uptime,
> Ive built plenty of kernels easily before, ive re created this problem on three
> machines with very different linux setups (kernel, distro, gcc version..)
> 
> (menuconfigs saved and attached as bloc.o-fail.gz)
> 
> --- /proc/version
> Linux version 2.4.2 (root@orion.dsh.org.uk) (gcc version 2.95.3 19991030
> (prerelease)) #8 Thu Oct 4 15:59:45 BST 2001
> 
> --- ver_linux
> linux orion.dsh.org.uk 2.4.2 #8 Thu Oct 4 15:59:45 BST 2001 i686 unknown
> Gnu C                  2.95.3
> Gnu make               3.79.1
> binutils               2.10.0.24
> util-linux             2.10b
> mount                  2.11b
> modutils               2.4.3
> e2fsprogs              1.19
> PPP                    2.3.10
> Linux C Library        2.2.2
> Dynamic linker (ldd)   2.2.2
> Procps                 2.0.7
> Net-tools              1.59
> Console-tools          0.2.2
> Sh-utils               2.0
> Modules Loaded
> 
> --- host info
> Machine Spec
> CPU : 1x AMD Duron 800Mhz
> RAM : 128Mb PC133
> M/B : GIGABYTE (VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 3))
> 
> --- /proc/cpuinfo
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 6
> model           : 3
> model name      : AMD Duron(tm) Processor
> stepping        : 1
> cpu MHz         : 800.042
> cache size      : 64 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
> bogomips        : 1595.80
> 
> --- lspci -vvv included as gzip
> --- no scsi in system
> --- no modules loaded at all (ever)
> 
> Hope this has been a helpful bug report
> 
> Ian Norton
> 



