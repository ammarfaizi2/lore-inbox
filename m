Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279798AbSBBXGi>; Sat, 2 Feb 2002 18:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282511AbSBBXGS>; Sat, 2 Feb 2002 18:06:18 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:6457 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S279798AbSBBXGO>; Sat, 2 Feb 2002 18:06:14 -0500
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
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 02 Feb 2002 16:02:28 -0700
In-Reply-To: <3C5C54D2.2030700@zytor.com>
Message-ID: <m1k7tv8p2z.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> The flaw in your understanding comes in when you want to run maintenance on a
> system, reinstall it, install a system for which you don't have drivers, etc.
> Otherwise you're basically requiring the memory on the target system to contain
> every driver that could possibly exist, not just today but in the future.

It does seem to be a requirement to contain every driver for at least
one class of devices in ram.  So it looks like Firmware to support
ease of administration needs to support loading both user-space
programs, and kernel-space programs.  At a first approximation I
agree, but I need to think on this some more. 

For the acceptance of a Linux booting Linux patch this case isn't a
problem because it is only an enabler, that is good news.

For the firmware case with LinuxBIOS that is an element I had not
thought of.  And it is a problem because it hinders automation.  The
only place a firm line has been drawn so far is where LinuxBIOS
stops, and where the in firmware bootloader begins.  Embedded systems
don't in general need or want the flexibility a full general purpose
firmware provides so can be ignored, but for general purpose systems
this is an issue.  The original design called for the using the Linux
kernel (in which case a trivial answer would be forthcoming) but in
many instances you cannot compile the Linux kernel small enough to be
useful. 

It can be argued that general purpose systems have enough ram that
putting drivers for all mass produced devices in ram is possible, and
practical.  But that is a cop out.

Eric
