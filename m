Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288012AbSBDUAc>; Mon, 4 Feb 2002 15:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287895AbSBDUAX>; Mon, 4 Feb 2002 15:00:23 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:1596 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S288047AbSBDUAC>; Mon, 4 Feb 2002 15:00:02 -0500
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
	<m1y9ia76f7.fsf@frodo.biederman.org> <3C5D91EB.4000900@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Feb 2002 12:55:51 -0700
In-Reply-To: <3C5D91EB.4000900@zytor.com>
Message-ID: <m1ofj56myg.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Eric W. Biederman wrote:
> 
> > The simplest is the observation that right now 10MB is about what it
> > takes to hold every Linux driver out there.  So all you really need is
> > a 16MB system, to avoid a device probing loader.  And probably
> > noticeably less than that.  The only systems I see having real
> > problems are old systems where device enumeration is not reliable, and
> > require human intervention anyway.
> >
> 
> 
> A floppy disk is 1.44 MB.

Yes floppies are small.  The nice thing is that there are only 2 or 3
floppy drivers in the kernel so it is not hard to include access to
the primary boot medium.  

Though actually last time I checked you can still fit all of the
kernels network drivers on a floppy, and it wouldn't surprise me if you
could do the same with cd drivers as well.

For other medium you can reduce the number of times you interact with
the user to exactly once, and that is worth handling.  For a floppy
you either have enough room for all of your drivers or you don't.
This doesn't really appear to affect the number of user interactions,
and doesn't seem to me to be a case that the presence of absence of
firmware callbacks makes a difference.  

The only difference I see with firmware callbacks is weather you are
working from BIOS user space or from kernel user space.

Eric

