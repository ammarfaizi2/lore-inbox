Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287862AbSBCXBw>; Sun, 3 Feb 2002 18:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287863AbSBCXBl>; Sun, 3 Feb 2002 18:01:41 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19973 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287862AbSBCXB3>; Sun, 3 Feb 2002 18:01:29 -0500
Message-ID: <3C5DC138.3080106@zytor.com>
Date: Sun, 03 Feb 2002 15:01:12 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Rob Landley <landley@trommello.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
In-Reply-To: <m1elk7d37d.fsf@frodo.biederman.org> <20020203221750.HMXG18301.femail20.sdc1.sfba.home.com@there> <3C5DB8B7.4030304@zytor.com> <20020203225841.IBCK18525.femail19.sdc1.sfba.home.com@there>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:

> 
> You can pivot_root after the bios hands control over to the kernel, sure.  
> But if the bios can actually boot from arbitrary blocks on the CD before the 
> kernel takes over, this is news to me.  And for the kernel to read from the 
> CD, it needs its drivers already loaded for it, so they have to be in that 
> 2.88 megs somewhere.  (Statically linked, ramdisk, etc.)
> 


No, the boot specification allows direct access to the CD.  See the El 
Torito specification, specifically the parts that talk about "no 
emulation" mode.


> I was just pointing out that small boot environments weren't going away any 
> time soon, even if floppy drivers were to finally manage it.  When you 
> install your system, the initial image you bootstrap from is generally tiny.
> 
> Now I'm not so familiar with that etherboot stuff, intel's whatsis 
> specification (PXE?) for sucking a bootable image through the network.  All 
> I've ever seen that boot is a floppy image, but I don't know if that's a 
> limitation in the spec or just the way people are using it...


That's just the way *some* people are using it.  Look at PXELINUX for 
something that doesn't.  PXELINUX can use the UDP API provided by the 
PXE specification to download arbitrary files, specified at runtime, via 
TFTP.

	-hpa


