Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314069AbSDZPbF>; Fri, 26 Apr 2002 11:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314070AbSDZPbE>; Fri, 26 Apr 2002 11:31:04 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:56589 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S314069AbSDZPbD>;
	Fri, 26 Apr 2002 11:31:03 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: hgchewml@optusnet.com.au
Date: Fri, 26 Apr 2002 17:30:37 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: File corruption when running VMware.
CC: "'Linux kernel mailing list'" <linux-kernel@vger.kernel.org>,
        riel@conectiva.com.br
X-mailer: Pegasus Mail v3.50
Message-ID: <37A7BD60863@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Apr 02 at 2:01, Rik van Riel wrote:
> On Wed, 24 Apr 2002, Hong-Gunn Chew wrote:
> 
> > I have a repeatable problem when running VMware workstation 3.00 and
> > 3.01.  The cause is still unknown, and could be VMware itself, the
> > hardware or the kernel.
> 
> If you can reproduce it without VMware or with only the
> open source part of VMware (ie without any of the binary
> only parts) we might have a chance of debugging it.

Hi again,
  one of 2.4.x kernel images available in SuSE's 8.0 has patched&enabled 
support for page tables in high memory, and this quickly revealed
incompatibility between VMware's vmmon page table handling and
ptes above directly mapped range.

  So if you have >890MB of RAM and your kernel is compiled with support
for pte in high memory, please stop using VMware, or reconfigure your 
kernel to not use pte in high memory (4GB config without pte-in-highmem
is OK). Using pte-in-highmem with vmmon will cause kernel oopses and/or 
memory corruption :-(

  If you do not have >890MB of memory, then reason for your memory corruption
is still unknown to me.
                                          Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
