Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265300AbTLGEte (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 23:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265302AbTLGEte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 23:49:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:42648 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265300AbTLGEtc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 23:49:32 -0500
Date: Sat, 6 Dec 2003 20:49:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Wakko Warner <wakko@animx.eu.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: cdrecord hangs my computer
In-Reply-To: <20031206191650.A4199@animx.eu.org>
Message-ID: <Pine.LNX.4.58.0312062038260.6329@home.osdl.org>
References: <Law9-F31u8ohMschTC00001183f@hotmail.com>
 <Pine.LNX.4.58.0312060011130.2092@home.osdl.org> <3FD1994C.10607@stinkfoot.org>
 <20031206084032.A3438@animx.eu.org> <Pine.LNX.4.58.0312061044450.2092@home.osdl.org>
 <20031206191650.A4199@animx.eu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 6 Dec 2003, Wakko Warner wrote:
> >
> > One is just plain confusion - anybody who uses cdrecord has either been
> > confused by the silly SCSI numbering (while "dev=/dev/hdc" is not
> > confusing at all, and uses the same device you use for mounting the thing
> > etc).
>
> Actually, it would be nice if I could use dev=/dev/scd0.  I do have a scsi
> burner (and an ide one too)

It _should_ just work these days. Anything that uses "cdrom_ioctl()"
should automatically get the SCSI command translation code (which isn't
part of the scsi driver).

But hey, the scsi layer confuses me. Less than it used to, but still.

		Linus
