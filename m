Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129450AbRAEGOJ>; Fri, 5 Jan 2001 01:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129455AbRAEGOA>; Fri, 5 Jan 2001 01:14:00 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:63246 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129267AbRAEGNl>; Fri, 5 Jan 2001 01:13:41 -0500
Date: Fri, 5 Jan 2001 00:13:22 -0600
To: mpradhan@healthnet.org.np
Cc: "Mike A. Harris" <mharris@opensourceadvocate.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Compilation error in Red Hat 6.2
Message-ID: <20010105001322.B4569@cadcamlab.org>
In-Reply-To: <3A54F8BD.14576.3D66AD@localhost> <Pine.LNX.4.31.0101041404550.27543-100000@asdf.capslock.lan> <3A553D9E.9293.2E81A9@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A553D9E.9293.2E81A9@localhost>; from mpradhan@healthnet.org.np on Fri, Jan 05, 2001 at 03:21:02AM +0530
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Kindly let me know in which part comes the IDE, ext2 and ELF after
> running the command make menuconfig.

Oh come on, these things aren't *that* hard to find.  In any case,
judging from the device number 08:01, I suspect you are using SCSI
rather than IDE.  Check your SCSI options.  You must compile in (not as
modules) the SCSI disk driver as well as your host adapter.

If you are indeed using IDE, make sure you are passing the correct root
dev into the booting kernel.  Check your boot loader config (lilo.conf,
likely as not) or try the 'rdev' utility.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
