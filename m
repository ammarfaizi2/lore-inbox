Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292388AbSBBVHN>; Sat, 2 Feb 2002 16:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292389AbSBBVHD>; Sat, 2 Feb 2002 16:07:03 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58384 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S292388AbSBBVHB>; Sat, 2 Feb 2002 16:07:01 -0500
Message-ID: <3C5C54D2.2030700@zytor.com>
Date: Sat, 02 Feb 2002 13:06:26 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "Erik A. Hendriks" <hendriks@lanl.gov>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org, Werner Almesberger <wa@almesberger.net>
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
In-Reply-To: <m1elk7d37d.fsf@frodo.biederman.org>	<3C586355.A396525B@zip.com.au> <m1zo2vb5rt.fsf@frodo.biederman.org>	<3C58B078.3070803@zytor.com> <m1vgdjb0x0.fsf@frodo.biederman.org>	<3C58CAE0.4040102@zytor.com> <20020131103516.I26855@lanl.gov>	<m1elk6t7no.fsf@frodo.biederman.org> <3C59DB56.2070004@zytor.com>	<m1r8o5a80f.fsf@frodo.biederman.org> <3C5A5F25.3090101@zytor.com>	<m1hep19pje.fsf@frodo.biederman.org> <3C5ADDD1.6000608@zytor.com> <m1665fame3.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

> 
> If you are correct, then there a fundamental design problem with my
> Linux Booting Linux code.  Because that is exactly what I do.  I stuff
> the kernel in memory and jump to it.  Once the new kernel starts there is
> no back and forth.  _Please_ help me understand why this back and
> forth is needed.  
> 
> Here is my experience.  Non-interactive etherboot, doesn't know what
> it is booting, or where it is booting from until the DHCP server tells
> it.  Then it gets a file from a TFTP server and boots that.
> 


This is one subcase, but one of many.

> 
> When booting the Linux kernel it never attempts to do a back and forth
> via the firmware to the boot medium.  Instead someone has a clue about
> what the boot medium was and it mounts that medium using it's own
> drivers.  Booting a rescue cd is a good example.
> 
> _Please_ help me find the flaw in my understanding.  
> 


The flaw in your understanding comes in when you want to run maintenance 
on a system, reinstall it, install a system for which you don't have 
drivers, etc.  Otherwise you're basically requiring the memory on the 
target system to contain every driver that could possibly exist, not 
just today but in the future.

	-hpa


