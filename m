Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262917AbTCKMiL>; Tue, 11 Mar 2003 07:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262919AbTCKMiL>; Tue, 11 Mar 2003 07:38:11 -0500
Received: from hibernia.jakma.org ([212.17.36.87]:59542 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP
	id <S262917AbTCKMiK>; Tue, 11 Mar 2003 07:38:10 -0500
Date: Tue, 11 Mar 2003 12:48:47 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Kenn Humborg <kenn@linux.ie>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make f_pos accessible via /proc/PID/fd/N
In-Reply-To: <20030303200323.A12223@excalibur.research.wombat.ie>
Message-ID: <Pine.LNX.4.44.0303111243130.9346-100000@fogarty.jakma.org>
X-NSA: iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Mar 2003, Kenn Humborg wrote:

> The attached patch sets the "size" for the /proc/PID/fd/N entries
> to the current file position (file->f_pos).
> 
> In proc_lookupfd(), I fill inode->i_size with file->f_pos.  Then
> in pid_fd_revalidate(), I refresh it again.
> 
> I would find this useful to be able to tell, for example, how far
> a large outgoing SMTP transfer has got (so I can avoid rebooting
> if it's almost finished), or how far a customer download from our
> FTP server has got to.

Cute little addition. This would be very useful to have.

> Was there any particular reason for fixing the "size" of these
> files at 64?  Are there any tools that depend on this?

If not it'd be very nice to have in the kernel.

> Patch is against 2.5.63.
> 
> Later,
> Kenn

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
	warning: do not ever send email to spam@dishone.st
Fortune:
Numeric stability is probably not all that important when you're guessing.

