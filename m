Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266611AbUHZAxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266611AbUHZAxi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 20:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266561AbUHZAvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 20:51:54 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:22457 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266603AbUHZAvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 20:51:23 -0400
Date: Thu, 26 Aug 2004 02:51:22 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <Pine.LNX.4.58.0408251723540.17766@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0408260233400.29842@artax.karlin.mff.cuni.cz>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com>
 <20040825200859.GA16345@lst.de> <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org>
 <Pine.LNX.4.58.0408260204050.22259@artax.karlin.mff.cuni.cz>
 <Pine.LNX.4.58.0408251723540.17766@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The only way xattrs are useful is that backup/restore software doesn't
> > have to know about every filesystem with it's specific attributes and
> > every magic ioctl for setting them. Instead it can save/restore
> > filesystem-specific attributes without understanding what do they mean.
> > However there's no need why application should use them. And no
> > application does.
>
> If no application does, then why back them up? Why implement them in the
> first place?
>
> In other words - some apps obviously do want to use the. Sadly.

You can add more functionality to filesystem and use xattrs to control it.
For example:
- acls
- compress file
- encrypt file (copy user's password into task_struct and use it to
encrypt his files)
- preallocate file in 4MB contignuous chunks, becuase it needs real time
multimedia access
- sync/append-only/immutable
etc.
However there's no need why an application should care whether the file is
compressed, whether it has acls, or so. And applications don't.

And I think this is the only legitimate use for xattrs. Who else uses them
except samba? I don't see how reiser4's hybrids would help.

Mikulas
