Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWG0PvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWG0PvS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 11:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWG0PvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 11:51:18 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38081 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750801AbWG0PvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 11:51:17 -0400
Subject: Re: Re: [RFC/PATCH] revoke/frevoke system calls V2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@zeniv.linux.org.uk, tytso@mit.edu, tigran@veritas.com
In-Reply-To: <84144f020607270833v4c981d00w8e3e643406aea7a@mail.gmail.com>
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
	 <1154012822.13509.52.camel@localhost.localdomain>
	 <84144f020607270833v4c981d00w8e3e643406aea7a@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Jul 2006 17:09:49 +0100
Message-Id: <1154016589.13509.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-07-27 am 18:33 +0300, ysgrifennodd Pekka Enberg:
> Don't device drivers already do that for f_ops->flush (filp_close) and

->flush is called when each closing occurs.

> vm_ops->close (munmap)? What revoke and frevoke do is basically
> unmap/fsync/close on all the open file descriptors.

What happens if an app is already blocked on a read when you do a
revoke ? The nasty case answer could be "it completes later on and
returns the users captured password"

Alan

