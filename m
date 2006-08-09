Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbWHISA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWHISA2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 14:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWHISA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 14:00:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:30366 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751287AbWHISA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 14:00:27 -0400
X-Authenticated: #271361
Date: Wed, 9 Aug 2006 20:00:19 +0200
From: Edgar Toernig <froese@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       akpm@osdl.org, viro@zeniv.linux.org.uk, tytso@mit.edu,
       tigran@veritas.com
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
Message-Id: <20060809200019.0bd5eecd.froese@gmx.de>
In-Reply-To: <1155120128.5729.143.camel@localhost.localdomain>
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
	<20060805122936.GC5417@ucw.cz>
	<20060807101745.61f21826.froese@gmx.de>
	<84144f020608070251j2e14e909v8a18f62db85ff3d4@mail.gmail.com>
	<20060807224144.3bb64ac4.froese@gmx.de>
	<1155040157.5729.34.camel@localhost.localdomain>
	<20060809104155.48ad3c77.froese@gmx.de>
	<1155120128.5729.143.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>
> Ar Mer, 2006-08-09 am 10:41 +0200, ysgrifennodd Edgar Toernig:
> > > If I own the file I can make it a symlink to a pty/tty pair
> > > I can revoke a pty/tty pair
> > 
> > With the EIO/EOF behaviour that's not a problem - apps that deal
> > with ttys have to expect that condition.
> 
> Think about it a moment - I can symlink any file to a tty/pty pair so
> any file I own you open might be a tty.

Yes, OK.  The EIO/EOF behaviour is fine.  Even for regular files it's
not something extraordinary.

> > Hmm... which apps have an open fd on block devices?  Usually a
> 
> cdrecord, cd audio players, eject, ....

And killing them is not OK?  "fuser -km /dev/cdrom" already covers both
cases, mounted somewhere and opened for special access.


Sorry if I sound a little bit anal.  IMO, a generic revoke is a pretty
sharp sword which is given to ordinary users and I have a very uneasy
feeling.  They can dig in the innards of other people's processes - a
clean headshot by root is something different ...

Ciao, ET.
