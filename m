Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313620AbSDPGnI>; Tue, 16 Apr 2002 02:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313621AbSDPGnH>; Tue, 16 Apr 2002 02:43:07 -0400
Received: from web10407.mail.yahoo.com ([216.136.130.99]:28934 "HELO
	web10407.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S313620AbSDPGnG>; Tue, 16 Apr 2002 02:43:06 -0400
Message-ID: <20020416064306.91089.qmail@web10407.mail.yahoo.com>
Date: Tue, 16 Apr 2002 16:43:06 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: Re: 2.4.19-pre6aa1 (possible all kernel after 2.4.19-pre2) athlon PCI workaround
To: kernel <linux-kernel@vger.kernel.org>
Cc: Kurt Garloff <garloff@suse.de>
In-Reply-To: <20020415174059.E2345@nbkurt.etpnet.phys.tue.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I don't know of an "official way".


I think this is a known problem but it is strange that
no one bother to implement something to make it easier
for the end user to compile their own kernel rather
than seraching the file and edit it . Of course I
believe my box is not the only one suffering such
problem.


> There were a number of postings refering to
> arch/i386/kernel/pci-pc.c:
> pci_fixup_via_northbridge_bug()

Just after posting my first email, I found the file,
yes it is in arch/i386/kernel/pci-pc.c and I just
comment out all lines in struct pci_fixup
pcibios_fixups[] related to VIA; that is
PCI_FIXUP_HEADER, PCI_VENDOR_ID_VIA  etc...

I have no idea if this affects the system, but it
seemed that the problem is solved and no thing wierd
happened yet :-). May be if I got some trouble I will
set the bit as you said. 


> and claiming that not clearing bit 5 did make the
> problem go away.
> (IOW: Replace v &= 0x1f; /* clear bits 5, 6, 7 */
>            by v &= 0x3f; /* clear bits 6, 7 */
>  and see whether this helps.)
> 
> Regards,

Thanks for your reply



=====
Steve Kieu

http://messenger.yahoo.com.au - Yahoo! Messenger
- A great way to communicate long-distance for FREE!
