Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265261AbTLFV5U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 16:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265262AbTLFV5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 16:57:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:55694 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265261AbTLFV5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 16:57:19 -0500
Date: Sat, 6 Dec 2003 13:57:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Wakko Warner <wakko@animx.eu.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: cdrecord hangs my computer
In-Reply-To: <20031206084032.A3438@animx.eu.org>
Message-ID: <Pine.LNX.4.58.0312061044450.2092@home.osdl.org>
References: <Law9-F31u8ohMschTC00001183f@hotmail.com>
 <Pine.LNX.4.58.0312060011130.2092@home.osdl.org> <3FD1994C.10607@stinkfoot.org>
 <20031206084032.A3438@animx.eu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 6 Dec 2003, Wakko Warner wrote:
>
> At the moment, I don't have a burner on a 2.6.0 machine, however, why is
> ide-scsi depreciated?

Several reasons.

One is just plain confusion - anybody who uses cdrecord has either been
confused by the silly SCSI numbering (while "dev=/dev/hdc" is not
confusing at all, and uses the same device you use for mounting the thing
etc).

Another is that several things did _not_ work well with ide-scsi. Some
people ended up having to boot with ide-scsi enabled to burn CD's, but
then if they wanted to watch DVD's (on the same drive), they needed to
boot without it.

>		 On every PC I have that has an ide cd drive, I use
> ide-scsi.  I like the fact that scd0 is the cdrom drive.

And you liked the fact that you were supposed to write "dev=0,0,0" or
something strange like that? What a piece of crap it was.

		Linus
