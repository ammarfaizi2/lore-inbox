Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285060AbSBDUVC>; Mon, 4 Feb 2002 15:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288092AbSBDUUw>; Mon, 4 Feb 2002 15:20:52 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:4668 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S285060AbSBDUUk>; Mon, 4 Feb 2002 15:20:40 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Erik A. Hendriks" <hendriks@lanl.gov>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org, Werner Almesberger <wa@almesberger.net>
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
In-Reply-To: <m1elk7d37d.fsf@frodo.biederman.org>
	<3C586355.A396525B@zip.com.au> <m1zo2vb5rt.fsf@frodo.biederman.org>
	<3C58B078.3070803@zytor.com> <m1vgdjb0x0.fsf@frodo.biederman.org>
	<3C58CAE0.4040102@zytor.com> <20020131103516.I26855@lanl.gov>
	<m1elk6t7no.fsf@frodo.biederman.org> <3C59DB56.2070004@zytor.com>
	<m1r8o5a80f.fsf@frodo.biederman.org> <3C5A5F25.3090101@zytor.com>
	<m1hep19pje.fsf@frodo.biederman.org> <3C5ADDD1.6000608@zytor.com>
	<m1665fame3.fsf@frodo.biederman.org> <3C5C54D2.2030700@zytor.com>
	<m1k7tv8p2z.fsf@frodo.biederman.org> <3C5C98E6.2090701@zytor.com>
	<m1y9ia76f7.fsf@frodo.biederman.org> <3C5D940D.4000406@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Feb 2002 13:16:54 -0700
In-Reply-To: <3C5D940D.4000406@zytor.com>
Message-ID: <m1g04h6lzd.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Ok, now let me ask the question that hopefully should be obvious to everyone
> now...
> 
> WHAT'S THE POINT?
> 
> All you're doing is an awfully complex song and dance to *avoid* implementing a
> solution that, while imperfect, is thoroughly established and has worked for 20
> years.

The x86 BIOS doesn't work for me.

As for a complex song and dance.  That is the complex song and dance
of double checking my design.  I am working through and making certain
there are no important cases that I have missed.  And the case of a
kernel that can boot on all machines, and having problems because of
limited memory resources is one case I admit I had not considered.  

Beyond that there are some real advantages from my perspective to
solutions that involve only one transaction.  You greatly increase the
odds that your code does not hit a code path that hasn't been tested
and doesn't work.

And I have no intentions of implementing PXE on top of the linux
kernel, just so I can netboot.  Which is what I would have to do to
use a 20 year old solution.

Plus working with the ELF format except for the exact differences of
where code loads in memory I solve the same problem for all linux
platforms, and I just need to port kexec to have it work.

Eric

