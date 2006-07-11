Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbWGKJyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWGKJyn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 05:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWGKJyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 05:54:43 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:4490 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750902AbWGKJym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 05:54:42 -0400
Subject: Re: tty's use of file_list_lock and file_move
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Theodore Tso <tytso@mit.edu>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e4733910607101916y4638c097ie26ae63a9949bc3e@mail.gmail.com>
References: <9e4733910607100810r6e02f69g9a3f6d3d1400b397@mail.gmail.com>
	 <1152552806.27368.187.camel@localhost.localdomain>
	 <9e4733910607101027g5f3386feq5fc54f7593214139@mail.gmail.com>
	 <1152554708.27368.202.camel@localhost.localdomain>
	 <9e4733910607101535i7f395686p7450dc524d9b82ae@mail.gmail.com>
	 <1152573312.27368.212.camel@localhost.localdomain>
	 <9e4733910607101604j16c54ef0r966f72f3501cfd2b@mail.gmail.com>
	 <9e4733910607101649m21579ae2p9372cced67283615@mail.gmail.com>
	 <20060711012904.GD30332@thunk.org>
	 <9e4733910607101916y4638c097ie26ae63a9949bc3e@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 11 Jul 2006 11:12:32 +0100
Message-Id: <1152612752.18028.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-07-10 am 22:16 -0400, ysgrifennodd Jon Smirl:
> I'm not looking for performance gains, I'm looking more to isolate the
> tty code down to a minimal set of interactions with the rest of the
> kernel. RIght now it is all intertwined.

That might be tricky given that hangup and SAK have to directly interact
with the VFS locking. 

Alan
