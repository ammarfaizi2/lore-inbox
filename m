Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287440AbSAPUXs>; Wed, 16 Jan 2002 15:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287450AbSAPUXi>; Wed, 16 Jan 2002 15:23:38 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51212 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287440AbSAPUX2>; Wed, 16 Jan 2002 15:23:28 -0500
Message-ID: <3C45E131.3060308@zytor.com>
Date: Wed, 16 Jan 2002 12:23:13 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en, sv
MIME-Version: 1.0
To: andersen@codepoet.org
CC: linux-kernel@vger.kernel.org
Subject: Re: Query about initramfs and modules
In-Reply-To: <15428.47094.435181.278715@irving.iisd.sra.com> <Pine.GSO.4.21.0201152226100.4339-100000@weyl.math.psu.edu> <20020116194121.GC32184@codepoet.org> <a24lub$4o9$1@cesium.transmeta.com> <20020116201823.GA1872@codepoet.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:

>>>
>>Yeah!  Let's put all this crap in KERNEL SPACE!  *NOT!*
>>
> 
> Good point.  We surely wouldn't want to have an ELF interpreter
> in kernel space.  That would be evil!  
> 	rm linux/fs/binfmt_elf.c
> There, thats better, now userspace can load everything.  If we
> can figure out how to get userspace loaded....
> 
> The kernel already knows how to load ELF files, and _has_ to do
> that job to get userspace running anyways.   So why not use that
> mechanism for modules?
> 


Because it's not the same mechanism at all.  insmod is an ELF *LINKER*,
not just a loader for executable-format ELF files.  There is a huge
difference between a linkable and an executable ELF file; a module is the
former, a binary executable is the latter.

	-hpa


