Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030294AbWGaRsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030294AbWGaRsw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 13:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbWGaRsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 13:48:52 -0400
Received: from mail.teleformix.com ([12.15.20.75]:18312 "EHLO
	mail.teleformix.com") by vger.kernel.org with ESMTP
	id S1030293AbWGaRsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 13:48:51 -0400
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
	regarding reiser4 inclusion
From: Dan Oglesby <doglesby@teleformix.com>
Reply-To: doglesby@teleformix.com
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: Rudy Zijlstra <rudy@edsons.demon.nl>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       Matthias Andree <matthias.andree@gmx.de>, vonbrand@inf.utfsm.cl,
       ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
In-Reply-To: <20060731173239.GO31121@lug-owl.de>
References: <1153760245.5735.47.camel@ipso.snappymail.ca>
	 <200607241806.k6OI6uWY006324@laptop13.inf.utfsm.cl>
	 <20060731125846.aafa9c7c.reiser4@blinkenlights.ch>
	 <20060731144736.GA1389@merlin.emma.line.org>
	 <20060731175958.1626513b.reiser4@blinkenlights.ch>
	 <20060731162224.GJ31121@lug-owl.de>
	 <Pine.LNX.4.64.0607311842120.13492@nedra.edsons.demon.nl>
	 <20060731173239.GO31121@lug-owl.de>
Content-Type: text/plain
Organization: Teleformix, LLC
Date: Mon, 31 Jul 2006 12:46:57 -0500
Message-Id: <1154368017.7964.50.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-31 at 19:32 +0200, Jan-Benedict Glaw wrote:
> On Mon, 2006-07-31 18:44:33 +0200, Rudy Zijlstra <rudy@edsons.demon.nl> wrote:
> > On Mon, 31 Jul 2006, Jan-Benedict Glaw wrote:
> > > On Mon, 2006-07-31 17:59:58 +0200, Adrian Ulrich 
> > > <reiser4@blinkenlights.ch> wrote:
> > > > A colleague of mine happened to create a ~300gb filesystem and started
> > > > to migrate Mailboxes (Maildir-style format = many small files (1-3kb))
> > > > to the new LUN. At about 70% the filesystem ran out of inodes; Not a
> > >
> > > So preparation work wasn't done.
> > 
> > Of course you are right. Preparation work was not fully done. And using 
> > ext1 would also have been possible. I suspect you are still using ext1, 
> > cause with proper preparation it is perfectly usable.
> 
> Oh, and before people start laughing at me, here are some personal or
> friend's experiences with different filesystems:
> 
>   * reiser3: A HDD containing a reiser3 filesystem was tried to be
>     booted on a machine that fucked up DMA writes. Fortunately, it
>     crashed really soon (right after going for read-write.)  After
>     rebooting the HDD on a sane PeeCee, it refused to boot. Starting
>     off some rescue system showed an _empty_ root filesystem.
> 
>   * A friend's XFS data partition (portable USB/FireWire HDD) once
>     crashed due to being hot-unplugged off the USB.  The in-kernel XFS
>     driver refused to mount that thing again, and the tools also
>     refused to fix any errors. (Don't ask, no details at my hands...)
> 
>   * JFS just always worked for me. Though I've never ever had a broken
>     HDD where it (or it's tools) could have shown how well-done they
>     were, so from a crash-recovery point of view, it's untested.
> 
>   * Being a regular ext3 user, I had lots of broken HDDs containing
>     ext3 filesystems. For every single case, it has been easy fixing
>     the filesystem after cloning. Just _once_, fsck wasn't able to fix
>     something, so I did it manually with some disk editor. This worked
>     well because the on-disk data structures are actually as simple as
>     they are.
> 
> ext3 always worked well for me, so why should I abandon it?
> 
> MfG, JBG

I've lost EXT2 and EXT3 filesystems from machines with no bad hardware
(power loss during writes).

I've recovered all but a handful of files from a RAID-5 array running
ReiserFS v3 that had two drives fail in rapid succession with bad
sectors.

Sometimes you're lucky, sometimes you're not.

--Dan

