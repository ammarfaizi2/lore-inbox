Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135654AbRAYSMl>; Thu, 25 Jan 2001 13:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132985AbRAYSMb>; Thu, 25 Jan 2001 13:12:31 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:48847 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S135654AbRAYSMS>;
	Thu, 25 Jan 2001 13:12:18 -0500
Date: Thu, 25 Jan 2001 19:12:09 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200101251812.TAA07239@harpo.it.uu.se>
To: jhartmann@valinux.com
Subject: Re: x86 PAT errata
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Hartmann wrote:
> > Before people get too exited about the x86 Page Attribute Table ...
> > Does Linux use mode B (CR4.PSE=1) or mode C (CR4.PAE=1) paging?
> > If so, known P6 errata must be taken into account.
> > In particular, Pentium III errata E27 and Pentium II errata A56
> > imply that only the low four PAT entries are working for 4KB
> > pages, if CR4.PSE or CR4.PAE is enabled.
> ...
> Yes it does use PSE/PAE paging.  Could you point me to these errata 
> documents?  According to the documentation I've seen it says that only 
> the low four PAT entries work for 4MB pages.  I've never seen 
> documentation that says the same is true for 4k pages.

They're called "Specification Updates" and are available at
developer.intel.com in the same place you get the manuals
and other docs. The Pentium III one is at
http://developer.intel.com/design/PentiumIII/specupdt/.
According to the errata, one bit which should be used for selecting
PAT entry is forced to zero for 4KB pages, which limits them
to the low four PAT entries. Large pages get to use all entries.

/Mikael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
