Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317260AbSGOAWM>; Sun, 14 Jul 2002 20:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317262AbSGOAWL>; Sun, 14 Jul 2002 20:22:11 -0400
Received: from chaos.analogic.com ([204.178.40.224]:13442 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317260AbSGOAWK>; Sun, 14 Jul 2002 20:22:10 -0400
Date: Sun, 14 Jul 2002 20:29:00 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Joerg Schilling <schilling@fokus.gmd.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
In-Reply-To: <200207141400.g6EE0brJ019110@burner.fokus.gmd.de>
Message-ID: <Pine.LNX.3.95.1020714202607.20849A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jul 2002, Joerg Schilling wrote:

> >From root@chaos.analogic.com Fri Jul 12 22:18:47 2002
> 
> >As much as I hate IDE, IDE isn't going away. All my systems use SCSI
> >so on machines that have CD/ROMS, I use your libraries and your tools.
> 
> >Maybe somebody should make CD/ROM code that directly talks to IDE via
> >/dev/hdwhatever, instead of expecting you to modify your code that
> >has worked so well for so long.
> 
> This would be a really bad idea.
> 
> Such a change would force me to add a 6th (and unneeded) new interface.
> Why? What problem would be solved if you did introduce such an interface?
> 

Well for one thing it eliminates the requirement to
include SCSI interface code on machines that don't
have SCSI. That's the practical aspect.

Now, the esoteric. Do you truly think that it is
proper to encapsulate devices in various layers?

The IDE interface, if it wasn't for the bug-workarounds,
is just a floppy disk interface that uses a different
controller chip. It is register-based, not message-
based. If you throw in a message-based control layer
(SCSI), what problems are you solving? It's a
rhetorical question. No answer is required.

Like I said before, your stuff works great. I use
it because I use SCSI. Somebody needs to write some
CD access code for IDE drives because they are not
going away. Maybe that 'somebody' is not you. You
certainly don't want to mess up good working code.

But I, for one, would feel a bit better about the
future IDE/CDROM code if you wrote it.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

