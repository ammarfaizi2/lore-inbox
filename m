Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291903AbSBAS12>; Fri, 1 Feb 2002 13:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291902AbSBAS1S>; Fri, 1 Feb 2002 13:27:18 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28173 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291901AbSBAS1A>; Fri, 1 Feb 2002 13:27:00 -0500
Message-ID: <3C5ADDD1.6000608@zytor.com>
Date: Fri, 01 Feb 2002 10:26:25 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "Erik A. Hendriks" <hendriks@lanl.gov>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org, Werner Almesberger <wa@almesberger.net>
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
In-Reply-To: <m1elk7d37d.fsf@frodo.biederman.org>	<3C586355.A396525B@zip.com.au> <m1zo2vb5rt.fsf@frodo.biederman.org>	<3C58B078.3070803@zytor.com> <m1vgdjb0x0.fsf@frodo.biederman.org>	<3C58CAE0.4040102@zytor.com> <20020131103516.I26855@lanl.gov>	<m1elk6t7no.fsf@frodo.biederman.org> <3C59DB56.2070004@zytor.com>	<m1r8o5a80f.fsf@frodo.biederman.org> <3C5A5F25.3090101@zytor.com> <m1hep19pje.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

> 
> What is magic about interactivity?  What makes this a different
> problem?  We approach booting from totally different perspectives,
> which makes communicating clearly hard.  
> 
> If you spell out individual problems I will show you how I would solve
> them.
> 


It makes it a very different problem because YOU DON'T KNOW WHAT YOU'RE 
BOOTING UNTIL THE USER TELLS YOU.

In fact, depending on just exactly what you're doing, you might not even 
know what you're booting until you have already gotten several items 
downloaded (consider, for example, a device-probing bootloader.)

Therefore, the bootloader must be able to obtain boot medium services 
not just once and for all, but on a back-and-forth basis.  There needs 
to be an API between the boot loader and the firmware, and just 
"stuffing it into memory" doesn't count.

	-hpa


