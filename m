Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317508AbSFEACt>; Tue, 4 Jun 2002 20:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316832AbSFEACs>; Tue, 4 Jun 2002 20:02:48 -0400
Received: from arsenal.visi.net ([206.246.194.60]:31894 "EHLO visi.net")
	by vger.kernel.org with ESMTP id <S316477AbSFEACp>;
	Tue, 4 Jun 2002 20:02:45 -0400
X-Virus-Scanner: McAfee Virus Engine
Date: Tue, 4 Jun 2002 19:54:43 -0400
From: Ben Collins <bcollins@debian.org>
To: Shanti Katta <katta@csee.wvu.edu>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Reg. sparc64 linker error
Message-ID: <20020604235443.GA1250@blimpo.internal.net>
In-Reply-To: <1023221667.12878.68.camel@indus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2002 at 04:14:26PM -0400, Shanti Katta wrote:
> Hi,
> I am trying to port user-mode-linux(uml) to Sparc64 arch. I am running a
> custom built 2.4.18 kernel on debian (sid), Ultra 1 system. I have also
> created static links sparc64-linux-ld and sparc64-linux-as. When I build
> the uml sources, I am getting the following linker error:
> 
> gcc-3.0  -Wall -Wstrict-prototypes -Wno-trigraphs -O2
> -fomit-frame-pointer -fno-strict-aliasing -fno-common -U__sparc64__
> -Usparc64 -m64 -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow
> -ffixed-g4 -fcall-used-g5 -fcall-used-g7 -Wno-sign-compare
> -Wa,--undeclared-regs -D__arch_um__ -DSUBARCH=\"sparc64\" -DNESTING=0
> -D_LARGEFILE64_SOURCE  -I/home/shanti/UML/UMLSparc64/arch/um/include
> -D_GNU_SOURCE -c -o unmap.o unmap.c
> ld -r -o unmap_fin.o unmap.o -lc -L/usr/lib
> ld: warning: sparc:v9 architecture of input file `unmap.o' is
> incompatible with sparc output
> ld: BFD 2.12.90.0.1 20020307 Debian/GNU Linux assertion fail
> ../../bfd/elflink.h:2817
> ld: final link failed: Bad value
> 
> I am using gcc-3.0 with binuitls 2.12.90.0.0.1-5. When I tried using gcc
> with egcs64, it gave me a bunch of parse errors. Hence, I switched to
> gcc-3.0. But now, I have this linker error. Any pointers in this
> direction would be appreciated.

gcc-3.0 may not work well. Eitherway, copy the CFLAGS/LDFLAGS from
arch/sparc64/Makefile. For this example above, you are missing -m64 as
an option to make it output 64bit executables.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://linux1394.sourceforge.net/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
