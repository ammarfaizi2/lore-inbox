Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264745AbSLFXKd>; Fri, 6 Dec 2002 18:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265177AbSLFXKc>; Fri, 6 Dec 2002 18:10:32 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:31913 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S264745AbSLFXKb>;
	Fri, 6 Dec 2002 18:10:31 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Patrick Mochel <mochel@osdl.org>
Date: Sat, 7 Dec 2002 00:18:05 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: /proc/pci deprecation?
Cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>,
       jgarzik@pobox.com
X-mailer: Pegasus Mail v3.50
Message-ID: <997222131F7@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  6 Dec 02 at 16:13, Patrick Mochel wrote:
> 
> > IIRC it was one of (a) deprecated, (b) removed, or (c) almost removed in
> > the past, and Linus un-deprecated it.  The logic back then was that it
> > provides a quick summary of a lot of useful info, a la /proc/cpuinfo and
> > /proc/meminfo.  i.e. you don't need lspci installed, just been /bin/cat.
> 
> Ok, I can see that. But, are there really many systems that do not come with
> lspci(8) pre-installed? I would expect that most distributions do; at least
> the one I use does..
> 
> But, look the usage model. Who queries PCI information from the system? I
> would argue a) developers, b) power users, and c) users hitting a bug. 

It is invaluable during installation, when no lspci is installed yet.
I know that I need e100/eepro100 for 
'Ethernet controller: Intel Corp. 82801BA/BAM/CA/CAM E', but I do not
have even slightest idea what device 8086:2449 is, whether USB or NIC or
VGA or some bridge.

Next problem is that some drivers want to print "user readable" hardware
name to user, and although some have its own name database (e100), some
use name from pcidev...
 
> > I do grant you it would make various __init sections and in-memory 
> > structures smaller if we eliminated the names...   do we want to?  Sure we
> > have lseisa and lspci and lsusb, et. al.  Does that obviate the need for a
> > simple summary of attached hardware?
> 
> IMO, yes, since those tools provide the summary, and exist almost purely in
> userspace. I forgot to mention in the orginal email that we could also drop
> the PCI names database, right? This would save a considerable amount in the
> kernel image alone..

If you want, make it user configurable like it was during 2.2.x. But
I personally prefer descriptive names and system overview I can parse 
without having mounted /usr to get working lspci.
                                                Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
