Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbUASRTV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 12:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265406AbUASRTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 12:19:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:15273 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261957AbUASRTP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 12:19:15 -0500
Date: Mon, 19 Jan 2004 09:15:13 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Atro.Tossavainen@helsinki.fi
Cc: atossava@cc.helsinki.fi, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Panic reading EFS CDs on SCSI CD drives through loop
Message-Id: <20040119091513.073d66fc.rddunlap@osdl.org>
In-Reply-To: <200401191145.i0JBjOsv013637@kruuna.Helsinki.FI>
References: <200401191145.i0JBjOsv013637@kruuna.Helsinki.FI>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jan 2004 13:45:24 +0200 (EET) Atro Tossavainen <atossava@cc.helsinki.fi> wrote:

| [1.] Reading files from EFS CD through loop-mounted SCSI CD causes panic
| 
| [2.] I am attempting to read Silicon Graphics IRIX installation CDs on
|      SCSI CD drives, either real SCSI or emulated IDE-SCSI drives.
| 
|      Since SCSI CD-ROMs can't set blocksize (IDE-SCSI emulated drives
|      included), I would usually do this with an IDE drive, disabling
|      ide-scsi temporarily if applicable.  However, the following article
| 
|      http://groups.google.fi/groups?selm=8765hq3j2u.fsf%40ID-48333.user.dfncis.de
| 
|      claims that by using the loop interface, it should be possible to
|      use EFS CDs with SCSI drives, too.
| 
|      I have tried this as follows:
| 
|      losetup /dev/loop0 /dev/scd0
|      mount -r -t efs /dev/loop0 /cdrom
|      cd /cdrom
|      tar cf - . | tar xv -C/somewhere/else -f-
| 
|      It reads a few files, then panics on a large file.  If I am running
|      X11, the only symptom I see is that the machine freezes totally and
|      the Caps Lock and Scroll Lock lights on the keyboard start blinking.
|      If I'm in the text console, it displays the message:
| 
| Kernel panic: scsi_free:Trying to free unused memory

Are there some other messages associated with this, like
a BUG or stack dump?  Those could be helpful.

--
~Randy
Everything is relative.
