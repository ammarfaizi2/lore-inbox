Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWHHL4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWHHL4b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 07:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbWHHL4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 07:56:31 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:28603 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932470AbWHHL4a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 07:56:30 -0400
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chase Venters <chase.venters@clientec.com>
Cc: Edgar Toernig <froese@gmx.de>, Pekka Enberg <penberg@cs.helsinki.fi>,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org, viro@zeniv.linux.org.uk,
       tytso@mit.edu, tigran@veritas.com
In-Reply-To: <Pine.LNX.4.64.0608071720510.29055@turbotaz.ourhouse>
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
	 <20060805122936.GC5417@ucw.cz> <20060807101745.61f21826.froese@gmx.de>
	 <84144f020608070251j2e14e909v8a18f62db85ff3d4@mail.gmail.com>
	 <20060807224144.3bb64ac4.froese@gmx.de>
	 <Pine.LNX.4.64.0608071720510.29055@turbotaz.ourhouse>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 08 Aug 2006 13:15:38 +0100
Message-Id: <1155039338.5729.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-08-07 am 17:24 -0500, ysgrifennodd Chase Venters:
> implementation is crude. "EBADF" is not something that applications are 
> taught to expect. Someone correct me if I'm wrong, but I can think of no 
> situation under which a file descriptor currently gets yanked out from 
> under your feet -- you should always have to formally abandon it with 
> close().

The file descriptor is not pulled from under you, the access to it is.
This is exactly what occurs today when a tty is hung up. That could be
almost any fd because paths could be symlinks to a pty/tty pair...

In the tty case you get -ENXIO

Alan

