Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315985AbSEGVyb>; Tue, 7 May 2002 17:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315884AbSEGVya>; Tue, 7 May 2002 17:54:30 -0400
Received: from ns.suse.de ([213.95.15.193]:49161 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S315985AbSEGVy3>;
	Tue, 7 May 2002 17:54:29 -0400
Date: Tue, 7 May 2002 23:50:17 +0200
From: Dave Jones <davej@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.14-dj1: misc.o: undefined reference to `__io_virt_debug'
Message-ID: <20020507235017.H12134@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.NEB.4.44.0205072137260.9347-100000@mimas.fachschaften.tu-muenchen.de> <278490000.1020811234@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2002 at 03:40:35PM -0700, Martin J. Bligh wrote:
 > > ld -m elf_i386 -Ttext 0x100000 -e startup_32 -o bvmlinux head.o misc.o
 > > piggy.o
 > Seems like you're not linking in lib/iodebug.c for some reason.
 > outb_quad calls readb, which calls __io_virt, which calls __io_virt_debug,
 > which is defined in iodebug.c

Problem seems to be that piggy.o is compressed, and hence has no
matching symbol to link to.  Fun.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
