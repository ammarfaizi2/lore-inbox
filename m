Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267695AbTAMAre>; Sun, 12 Jan 2003 19:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267698AbTAMAre>; Sun, 12 Jan 2003 19:47:34 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:28896 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S267695AbTAMArb>; Sun, 12 Jan 2003 19:47:31 -0500
Message-ID: <7071726.1042419087751.JavaMail.nobody@web55.us.oracle.com>
Date: Sun, 12 Jan 2003 16:51:27 -0800 (PST)
From: Alessandro Suardi <ALESSANDRO.SUARDI@oracle.com>
To: linux@brodo.de
Subject: Re: Kernel 2.5.55 failed to boot with ACPI support
Cc: andrew.grover@intel.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-Mailer: Oracle Webmail Client
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski wrote:

> On Mon, Jan 13, 2003 at 12:04:02AM +0100, Alessandro Suardi wrote:
> > Andrew Grover wrote:
> > 
> > > > From: Ole J. Hagen [mailto:olehag_2001@yahoo.no] 
> > > > I just wanted to inform that kernel-2.5.55 failes to boot 
> > > > when ACPI support is 
> > > > compiled in the kernel. 
> > > > 
> > > > I have following configuration; Dell Optiplex GX-240, Pentium 
> > > > 4 (1.5 GHz), ATI RAGE 128.
> > >
> > > How exactly does it fail?
> > 
> > My brand new Dell Latitude C640 oopses on boot in 2.5.56 if I
> >  have CPU_FREQ config'd in. ACPI without CPU_FREQ is okay - well,
> >  it screws my framebuffer screen (what 2.4.21-pre3 doesn't) when
> >  the ACPI code does its bootup printk's, but after that the
> >  screen recovers.
> >
> > ...
> >
> > Back on topic, if you're interested I can rebuild my 2.5.56 with
> >  CPU_FREQ and write down the backtrace of the oops.
> Would be great if you could do that - and tell what oops it is (NULL pointer
> dereference etc.), in case you still see that on your screen.

Sigh :(

Rebuilt with CPU_FREQ, doesn't oops. It says

cpufreq: Intel(R) SpeedStep(TM) for this processor not (yet) available

Is the above message expected ? The CPU is a 1.8Ghz mobile P4.

Still puzzled as to why... wait, this was a cold boot, let me try
 warmbooting... argh - the disk powered off. Bug 119 :(
Nope, coldbooted in 2.4.21-pre3, rebooted in 2.5.56, still had no
 oops with a CPU_FREQ enabled kernel.


--alessandro
