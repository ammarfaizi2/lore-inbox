Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291441AbSBAAER>; Thu, 31 Jan 2002 19:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291443AbSBAAEM>; Thu, 31 Jan 2002 19:04:12 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35079 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291441AbSBAAEA>; Thu, 31 Jan 2002 19:04:00 -0500
Message-ID: <3C59DB56.2070004@zytor.com>
Date: Thu, 31 Jan 2002 16:03:34 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en, sv
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "Erik A. Hendriks" <hendriks@lanl.gov>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org, Werner Almesberger <wa@almesberger.net>
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
In-Reply-To: <m1elk7d37d.fsf@frodo.biederman.org>	<3C586355.A396525B@zip.com.au> <m1zo2vb5rt.fsf@frodo.biederman.org>	<3C58B078.3070803@zytor.com> <m1vgdjb0x0.fsf@frodo.biederman.org>	<3C58CAE0.4040102@zytor.com> <20020131103516.I26855@lanl.gov> <m1elk6t7no.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

> 
> I already need a new format for LinuxBIOS, because I can't use
> bzImages.  
> 

[...]

> 
> Personally I think all of that is just flawed.  The bootloaders should
> be simple.  They should be able to load the ramdisk at a fixed address
> (assuming the memory isn't reserved).   And they shouldn't need to be
> changed every time the kernel has a problem.
> 


And your solution is to come up with a new format that is (a) MORE
complex, (b) DIFFERENT, (c) incompatible?

Give me a break.  You have just added so much complexity it's not even
funny.  I can guarantee you that people *WILL* ask for every single
existing bootloader out there to support your new format.  It's a support
nightmare for all of us that write bootloaders, and not just for you.

If your complaint is about the lack of a 32-bit entrypoint such can
probably be added to the existing format (it would require

Oh, and as far as "simple" is concerned, I should let you know that when I
work on syslinux, I count bytes.  The existing protocol is definitely
suboptimal in that respect (this is due to some severe mistakes which were
done in the original initrd implementation), but we're stuck with it.  All
you're accomplishing is creating two completely incompatible formats,
*BOTH* of which will need to be supported for the forseeable future.

	-hpa

