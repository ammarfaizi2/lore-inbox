Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310429AbSCBTu2>; Sat, 2 Mar 2002 14:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310430AbSCBTuT>; Sat, 2 Mar 2002 14:50:19 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:9770 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S310429AbSCBTuK>; Sat, 2 Mar 2002 14:50:10 -0500
Date: Sat, 2 Mar 2002 20:49:16 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Robert Love <rml@tech9.net>, h@dualathlon.random
Cc: Chris Rankin <cj.rankin@ntlworld.com>, rgooch@vindaloo.ras.ucalgary.ca,
        linux-kernel@vger.kernel.org
Subject: Re: NOW have 'D-state' processes in 2.4.17 !!!
Message-ID: <20020302204916.D27020@dualathlon.random>
In-Reply-To: <200203021818.g22IIo27021932@twopit.underworld> <1015093468.14000.1.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1015093468.14000.1.camel@phantasy>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 02, 2002 at 01:24:27PM -0500, Robert Love wrote:
> On Sat, 2002-03-02 at 13:18, Chris Rankin wrote:
> 
> > [Linux 2.4.17, SMP, devfs, 1.2 GB memory, compiled with gcc-2.95.3,
> > root partition using EXT3]
> > 
> > I upgraded to 2.4.18 a few days ago, but immediately downgraded
> > because I suddenly had lots of 'D-state' processes. Well I have now
> > produced a suspiciously-similar-looking D-state process using 2.4.17,
> > and I strongly suspect that either EXT3 or ALSA is somehow involved
> > because mounting my root partition as EXT3 and adding the latest CVS
> > ALSA modules are the only changes that I have made from my previous
> > reliable 2.4.17 setup.
> > 
> > The trace of the misbehaving process looks almost exactly like the
> > last trace from 2.4.18, except this time I have run it through
> > ksymoops:
> 
> Pretty clear from these traces it is ALSA - the tasks are going to sleep
> on some ALSA method and are not waking up.  Bug the ALSA people.
> 
> A good test would be to not use ALSA and see if it goes away.

Indeed.

Also please, don't call that 2.4.18 and 2.4.17 (like in subject and in a
earlier message you said 2.4.18 isn't going to be a keeper, you never
run 2.4.18 so you cannot say that). 2.4.18 is only this one:

	ftp://ftp.kernel.org/pub/linux/kernel/linux-2.4.18.tar.gz

As soon as you apply a patch to it, it's not longer 2.4.18, it's
2.4.18+patch.

It is very important to get accurate feedback. Linux isn't a microkernel
architecture, anything you change in any kernel subsystem can lead to
destabilize the rest of the kernel completly and so we need to know
exactly what change you made to the kernel before we can debug it.

Andrea
