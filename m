Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265115AbUGCN7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265115AbUGCN7k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 09:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265117AbUGCN7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 09:59:40 -0400
Received: from mail-ext.curl.com ([66.228.88.132]:42244 "HELO
	mail-ext.curl.com") by vger.kernel.org with SMTP id S265115AbUGCN7i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 09:59:38 -0400
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Szakacsits Szabolcs <szaka@sienet.hu>,
       Anton Altaparmakov <aia21@cam.ac.uk>, bug-parted@gnu.org,
       "K.G." <k_guillaume@libertysurf.fr>,
       Steffen Winterfeldt <snwint@suse.de>, Thomas Fehr <fehr@suse.de>,
       linux-kernel@vger.kernel.org, clausen@gnu.org, buytenh@gnu.org,
       msw@redhat.com
Subject: Re: [RFC] Restoring HDIO_GETGEO semantics (was: Re: workaround for BIOS / CHS stuff)
References: <Pine.LNX.4.21.0407030201520.30622-100000@mlf.linux.rulez.org>
	<200407030242.39075.bzolnier@elka.pw.edu.pl>
	<20040703005555.GA20808@apps.cwi.nl>
From: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Message-ID: <s5gekntqjnc.fsf@patl=users.sf.net>
Date: 03 Jul 2004 09:59:38 -0400
In-Reply-To: <20040703005555.GA20808@apps.cwi.nl>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <Andries.Brouwer@cwi.nl> writes:

> (ii) Various people talk about moving disks between machines.
> Such people have not understood the main fact here:
> the geometry is not a property of the disk but of the BIOS.

Um...  Yes, right, exactly, very good.  So you *must* obtain the
geometry from the BIOS and not from anything you happen to find on the
disk.  Which is sort of my entire point.

> It is futile to hope for a construction that will work across
> different machines with different BIOSes.

Simply false.  "modprobe edd.o" followed by an examination of the
fields under /sys/firmware/edd will give you precisely the right
values.

 - Pat
