Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265237AbUGCUM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265237AbUGCUM3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 16:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265238AbUGCUM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 16:12:29 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:19210 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S265237AbUGCUM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 16:12:28 -0400
Date: Sat, 3 Jul 2004 22:12:24 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Andrew Clausen <clausen@gnu.org>
Cc: "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>,
       Steffen Winterfeldt <snwint@suse.de>, bug-parted@gnu.org,
       Thomas Fehr <fehr@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Restoring HDIO_GETGEO semantics (was: Re: workaround for BIOS / CHS stuff)
Message-ID: <20040703201224.GC6456@pclin040.win.tue.nl>
References: <s5gwu1mwpus.fsf@patl=users.sf.net> <Pine.LNX.4.21.0407021528150.21499-100000@mlf.linux.rulez.org> <20040703013552.GA630@gnu.org> <s5g8ye1qjg9.fsf@patl=users.sf.net> <20040703144500.GL630@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040703144500.GL630@gnu.org>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : kweetal.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 04, 2004 at 12:45:00AM +1000, Andrew Clausen wrote:

> I was under the impression that 2.6 provides a mechanism for setting the
> HDIO_GETGEO thingy... so any program can tell Parted (and everything
> else, for that matter) what they want the geometry to be.

It is not a good idea to ask the user to tell the kernel so that the kernel
can tell parted. It is easier if one can tell parted directly.

> It contains this:
> 
> 	echo "bios_cyl:C bios_head:H bios_sect:S" > /proc/ide/hda/settings
> 
> Isn't the kernel the right place for this kind of communication to
> be happening, anyway?

No. This is stuff that is going away. It is a kludge that happens to work today.

Andries

