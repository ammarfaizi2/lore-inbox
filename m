Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318943AbSHEXVH>; Mon, 5 Aug 2002 19:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318944AbSHEXVH>; Mon, 5 Aug 2002 19:21:07 -0400
Received: from sabre.velocet.net ([216.138.209.205]:23558 "HELO
	sabre.velocet.net") by vger.kernel.org with SMTP id <S318943AbSHEXVG>;
	Mon, 5 Aug 2002 19:21:06 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Gregory Stark <gsstark@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: Oopses
References: <87sn1sgbcp.fsf@stark.dyndns.tv>
	<1028593411.18130.131.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1028593411.18130.131.camel@irongate.swansea.linux.org.uk>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 05 Aug 2002 19:24:36 -0400
Message-ID: <87k7n4ga8b.fsf@stark.dyndns.tv>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Tue, 2002-08-06 at 00:00, Gregory Stark wrote:
> > 
> > I received these two oopses recently running 2.4.17. Is this a known bug? 
> > Is it fixed in 2.4.18?
> > 
> > Aug  5 17:43:07 stark kernel: Unable to handle kernel paging request at virtual address e0f390e8
> > Aug  5 17:43:07 stark kernel:  printing eip:
> > Aug  5 17:43:07 stark kernel: c0140cfc
> > Aug  5 17:43:07 stark kernel: *pde = 00000000
> > Aug  5 17:43:07 stark kernel: Oops: 0002
> > Aug  5 17:43:07 stark kernel: CPU:    0
> > Aug  5 17:43:08 stark kernel: EIP:    0010:[get_empty_inode+44/160]    Tainted: PF
> 
> What binary modules are you running, and what did you use insmod -f on ?
> 

These modules are loaded. I wasn't running vmware at the time though.

Module                  Size  Used by    Tainted: PF 
sr_mod                 12312   0 (autoclean)
vmnet                  20544   4
vmmon                  19860   0 (unused)
openafs               403840   2
parport_pc             25608   1 (autoclean)
lp                      5984   0 (autoclean)
parport                24992   1 (autoclean) [parport_pc lp]
serial                 49696   0 (autoclean)
ide-scsi                7648   0
scsi_mod               50348   2 [sr_mod ide-scsi]
pppoe                   6880   8
pppox                   1160   1 [pppoe]
ppp_generic            15208   3 [pppoe pppox]
slhc                    4512   0 [ppp_generic]
3c59x                  24872   1
ne2k-pci                4832   1
8390                    5984   0 [ne2k-pci]
rtc                     5624   0 (autoclean)


-- 
greg

