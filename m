Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbUAMRSP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 12:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbUAMRSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 12:18:15 -0500
Received: from [212.239.224.50] ([212.239.224.50]:12183 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S264444AbUAMRSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 12:18:08 -0500
From: Jan De Luyck <lkml@kcore.org>
To: Hugang <hugang@soulinfo.com>, Bart Samwel <bart@samwel.tk>
Subject: Re: [PATCH] Laptop-mode v7 for linux 2.6.1
Date: Tue, 13 Jan 2004 18:17:42 +0100
User-Agent: KMail/1.5.4
Cc: Jens Axboe <axboe@suse.de>, Kiko Piris <kernel@pirispons.net>,
       linux-kernel@vger.kernel.org, Dax Kelson <dax@gurulabs.com>,
       Bartek Kania <mrbk@gnarf.org>, Simon Mackinlay <smackinlay@mail.com>
References: <3FFFD61C.7070706@samwel.tk> <4003E8BE.3000402@samwel.tk> <20040113222117.21d1ac0b@localhost>
In-Reply-To: <20040113222117.21d1ac0b@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401131817.42341.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 January 2004 15:21, Hugang wrote:
> On Tue, 13 Jan 2004 13:46:54 +0100
>
> Bart Samwel <bart@samwel.tk> wrote:
> > The reiserfs patch for "commit=" was included in Linux 2.6.1. I really
> > don't know if it works with laptop mode, haven't tested it -- I don't
> > use reiserfs. So, let's ask the world: is there anyone out there who is
> > running laptop mode *successfully* with reiserfs?
>
> Yes, I'm use reiserfs in 2.6.1 with laptop_mode patch. It works fine for
> me, I use cpudyn daemon to let spin download harddisk. In cpudyn.conf I
> changed TIMEOUT from 120 to 10. When i reading email/web, the harddisk can
> spin down for very long time (>3min).
>
> So you can try cpudynd.

Well, i used the smart-spindown script posted earlier, but even when not 
touching the laptop it gets a spindown of 40 seconds max. Then something 
always has to wake it up.

> /dev/hda13 on / type ext3 (rw,noatime,errors=remount-ro,commit=600)

It is rather annoying that this commit parameter isn't documented anywhere... 
man mount doesn't know it, nor does the kernel documentation.

Jan

-- 
The executioner is, I hear, very expert, and my neck is very slender.
		-- Anne Boleyn

