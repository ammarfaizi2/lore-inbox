Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129289AbQLOQRc>; Fri, 15 Dec 2000 11:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129423AbQLOQRV>; Fri, 15 Dec 2000 11:17:21 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:26392 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129289AbQLOQRN>; Fri, 15 Dec 2000 11:17:13 -0500
Date: Fri, 15 Dec 2000 16:46:26 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: ink@jurassic.park.msu.ru, ezolt@perf.zko.dec.com, axp-list@redhat.com,
        rth@twiddle.net, Jay.Estabrook@compaq.com,
        linux-kernel@vger.kernel.org, clinux@zk3.dec.com,
        wcarr@perf.zko.dec.com, linux-alpha@vger.kernel.org
Subject: Re: mm->context[NR_CPUS] and pci fix check [was Re: Alpha SCSI error on 2.4.0-test11]
Message-ID: <20001215164626.C16586@inspiron.random>
In-Reply-To: <20001201004049.A980@jurassic.park.msu.ru> <Pine.OSF.3.96.1001130171941.32335D-100000@perf.zko.dec.com> <20001130233742.A21823@athlon.random> <20001201145619.A553@jurassic.park.msu.ru> <20001201151842.C30653@athlon.random> <200012011819.KAA02951@pizda.ninka.net> <20001201201444.A2098@inspiron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001201201444.A2098@inspiron.random>; from andrea@suse.de on Fri, Dec 01, 2000 at 08:14:44PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2000 at 08:14:44PM +0100, Andrea Arcangeli wrote:
> On Fri, Dec 01, 2000 at 10:19:44AM -0800, David S. Miller wrote:
> > I would instead suggest to declare 'context' to be of an arch-specific
> > defined type, much like "thread_struct" is.
> 
> I agree, [..]

Here it is:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.0-test12/alpha-ASN-SMP-races-2.4.x-2

This one breaks all archs but i386 and alpha. If some arch maintainer likes me
to update its arch blindly implementing mm_arch structure as an `unsigned long
context' and fixing up the miscompilation I will do.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
