Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291210AbSAaR6Z>; Thu, 31 Jan 2002 12:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291209AbSAaR6P>; Thu, 31 Jan 2002 12:58:15 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4868 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291208AbSAaR6B>; Thu, 31 Jan 2002 12:58:01 -0500
Message-ID: <3C598585.4090004@zytor.com>
Date: Thu, 31 Jan 2002 09:57:25 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        Werner Almesberger <wa@almesberger.net>,
        "Erik A. Hendriks" <hendriks@lanl.gov>
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
In-Reply-To: <m1elk7d37d.fsf@frodo.biederman.org>	<3C586355.A396525B@zip.com.au> <m1zo2vb5rt.fsf@frodo.biederman.org>	<3C58B078.3070803@zytor.com> <m1vgdjb0x0.fsf@frodo.biederman.org>	<3C58CAE0.4040102@zytor.com> <m1r8o7ayo3.fsf@frodo.biederman.org>	<3C58DD2E.10106@zytor.com> <m1n0yvaucy.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

> 
>>From my experience PXE is not easier to use than coming up with my
> own.  At least not for machines that regularly need to network boot.
> And many motherboard manufacturers are happy to replace their PXE
> option rom with an etherboot option rom.
> 
> And besides not working well PXE is overly complicated, and
> intricately tied to the x86 BIOS.  I would rather simply follow the
> good internet RFC's and work on filling in the one missing piece.  A
> file format.  And the ELF file format works very well.  
> 

> Besides all of that of that I regularly network boot LinuxBIOS which
> PXE can't cope with.
> 
> Using etherboot I don't need a second stage bootloader.  Etherboot
> does work well.  I don't need anything beyond vanilla DHCP and TFTP
> (the standards for network booting).  The research into how to do it
> has really been done.  And I can work on interesting things like
> adding end to end checksums of the image I am booting.
> 


Etherboot requires a specific other driver.  The problem with what 
you're proposing -- and let me get it very clear here, it's a huge 
problem -- is that you have no device-independent access to the boot 
medium (in this case, the network) once you have loaded the initial boot 
program.  This is an enormous drawback.

That's the thing with PXE and the BIOS too, for that matter: they might 
be specs done by monkeys, but when it really counts, what you need is 
really there (modulo bugs, but that applies to everything.)

	-hpa

