Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267675AbUG3MxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267675AbUG3MxV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 08:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267669AbUG3MxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 08:53:21 -0400
Received: from guardian.hermes.si ([193.77.5.150]:21005 "EHLO
	guardian.hermes.si") by vger.kernel.org with ESMTP id S267675AbUG3MxM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 08:53:12 -0400
Message-ID: <B1ECE240295BB146BAF3A94E00F2DBFF09020D@piramida.hermes.si>
From: David Balazic <david.balazic@hermes.si>
To: David Balazic <david.balazic@hermes.si>,
       "'Matt Domsch'" <Matt_Domsch@dell.com>
Cc: Dave Jones <davej@redhat.com>, Andries Brouwer <aebr@win.tue.nl>,
       Jeff Garzik <jgarzik@pobox.com>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: RE: Weird:  30 sec delay during early boot
Date: Fri, 30 Jul 2004 14:52:14 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> ----------
> From: 	Matt Domsch[SMTP:Matt_Domsch@dell.com]
> Sent: 	29. julij 2004 18:02
> To: 	David Balazic
> Cc: 	Dave Jones; Andries Brouwer; Jeff Garzik; Pavel Machek; Linux
> Kernel; Andi Kleen; Andrew Morton
> Subject: 	Re: Weird:  30 sec delay during early boot
> 
> On Thu, Jul 29, 2004 at 03:05:10PM +0200, David Balazic wrote:
> > > David, you had said before that by downgrading your BIOS you no longer
> > > saw the delay.  Is this not still true?
> > > 
> > Still true, downgrading removes the delay.
> 
> OK, then I'm inclined to believe it's a BIOS bug really...
> 
> > > You also mentioned that Grub made different calls.  I'll check that
> > > out too.
> > > 
> > Can you make a patch, that only accesses hd0 and hd1 ?
> 
> Reduce the value of
> #define EDD_MBR_SIG_MAX 16
> 
> in include/linux/edd.h  to whatever value you like, e.g. 2.
> 
I set this to "1" and got the same delay ... :-(

> > Or one which prints what is it doing, on each step ?
> > ( I tried this one myself, but it did not work :blush: , IA32 assembler
> > is not my strong side )
> 
> That's more PITA - it's in real mode, before anything's ever been
> printed.  I'd prefer not to have to figure that out if I can avoid it.
> 
> Thanks,
> Matt
> 
> -- 
> Matt Domsch
> Sr. Software Engineer, Lead Engineer
> Dell Linux Solutions linux.dell.com & www.dell.com/linux
> Linux on Dell mailing lists @ http://lists.us.dell.com
> 
