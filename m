Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262779AbSLBPLr>; Mon, 2 Dec 2002 10:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262783AbSLBPLr>; Mon, 2 Dec 2002 10:11:47 -0500
Received: from viola.sinor.ru ([217.70.106.9]:55220 "EHLO viola.sinor.ru")
	by vger.kernel.org with ESMTP id <S262779AbSLBPLq> convert rfc822-to-8bit;
	Mon, 2 Dec 2002 10:11:46 -0500
Date: Mon, 2 Dec 2002 21:17:30 +0600
From: "Andrey R. Urazov" <coola@ngs.ru>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: a bug in autofs
Message-ID: <20021202151730.GB885@ktulu>
References: <20021201071612.GA936@ktulu> <1038799532.15370.301.camel@ixodes.goop.org> <20021202075725.GC1459@ktulu> <1038818346.3253.17.camel@ixodes.goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1038818346.3253.17.camel@ixodes.goop.org>
User-Agent: Mutt/1.4i
X-PGP-public-key: pub 1024D/02B49FF2
X-PGP-fingerprint: A1CE D50E 0CF3 C0EF BA35  CBEC 87D7 4A2B 02B4 9FF2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2002 at 12:39:06AM -0800, Jeremy Fitzhardinge wrote:
> > > What happens if you try to manually mount the cdrom when there's
> > > nothing in the drive?
> > [root@ktulu coola]# en mount -o ro -t iso9660 /dev/cdrom /mnt
> > mount: No medium found
> > 
> > with this attempt a new line reading `cdrom: open failed' is appended to
> > the dmesg output
> 
> Don't really know about this.  Autofs just uses mount to mount the
> filesystem, so whatever happens when you manually mount should also
> happen when you automount.  What's "en"?  Is this the same mount command
> line as automount execs?  What's in your auto.master?  Which module are
> you using?
"en" is script changing locale to en_US so that you see message in
English.

auto.master:

# $Id: auto.master,v 1.2 1997/10/06 21:52:03 hpa Exp $
# Sample auto.master file
# Format of this file:
# mountpoint map options
# For details of the format look at autofs(8).
/misc	/etc/auto.misc	--timeout=60

Just tested that the system hangs when the autofs4 module is in use.
autofs (without 4) module does not cause any problems.

What is characteristic is that before the system hangs I get numerous
messages reading `invalid seek on drive /dev/hdc' on my virtual console.


Best regards,
  Andrey Urazov
-- 
F:	When into a room I plunge, I
	Sometimes find some VIOLET FUNGI.
	Then I linger, darkly brooding
	On the poison they're exuding.
		-- The Roguelet's ABC
--
lundi 02 décembre, 2002, 21:05:18 +0600 - Andrey R. Urazov (mailto:coola@ngs.ru)

