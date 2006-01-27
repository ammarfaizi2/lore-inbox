Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbWA0AbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWA0AbM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 19:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWA0AbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 19:31:12 -0500
Received: from hiauly1.hia.nrc.ca ([132.246.100.193]:31247 "EHLO
	hiauly1.hia.nrc.ca") by vger.kernel.org with ESMTP id S964797AbWA0AbI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 19:31:08 -0500
Message-Id: <200601270028.k0R0STBB021468@hiauly1.hia.nrc.ca>
Subject: Re: [parisc-linux] Re: [PATCH 3/6] C-language equivalents of
To: grundler@parisc-linux.org (Grant Grundler)
Date: Thu, 26 Jan 2006 19:28:29 -0500 (EST)
From: "John David Anglin" <dave@hiauly1.hia.nrc.ca>
Cc: grundler@parisc-linux.org, mita@miraclelinux.com,
       linux-kernel@vger.kernel.org, ink@jurassic.park.msu.ru, spyro@f2s.com,
       dev-etrax@axis.com, dhowells@redhat.com, ysato@users.sourceforge.jp,
       torvalds@osdl.org, linux-ia64@vger.kernel.org, takata@linux-m32r.org,
       linux-m68k@vger.kernel.org, gerg@uclinux.org, linux-mips@linux-mips.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       linux390@de.ibm.com, linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, uclinux-v850@lsi.nec.co.jp, ak@suse.de,
       chris@zankel.net
In-Reply-To: <20060126230443.GC13632@colo.lackof.org> from "Grant Grundler" at Jan 26, 2006 04:04:43 pm
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yeah, about the same for parisc.
> 
> > Clearly the smallest of the lot with the smallest register pressure,
> > being the best candidate out of the lot, whether we inline it or not.
> 
> Agreed. But I expect parisc will have to continue using it's asm
> sequence and ignore the generic version. AFAIK, the compiler isn't that
> good with instruction nullification and I have other issues I'd
> rather work on.

I looked at the assembler code generated on parisc with 4.1.0 (prerelease).
The toernig code is definitely inferior.  The mita sequence is four
instructions longer than the arm sequence, but it didn't have any branches.
The arm sequence has four branches.  Thus, it's not clear to me which
would perform better in the real world.  There were no nullified instructions
generated for any of the sequences.  However, neither is as good as the
handcraft asm sequence currently being used.

Dave
-- 
J. David Anglin                                  dave.anglin@nrc-cnrc.gc.ca
National Research Council of Canada              (613) 990-0752 (FAX: 952-6602)
