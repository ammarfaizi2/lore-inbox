Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266271AbUITLir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266271AbUITLir (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 07:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266273AbUITLir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 07:38:47 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:8616 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S266271AbUITLip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 07:38:45 -0400
Date: Mon, 20 Sep 2004 13:38:44 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Olaf Hering <olh@suse.de>
cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: OOM & [OT] util-linux-2.12e
In-Reply-To: <20040920112607.GA19073@suse.de>
Message-ID: <Pine.LNX.4.61.0409201331320.3460@scrub.home>
References: <UTC200409192205.i8JM52C25370.aeb@smtp.cwi.nl> <20040920094602.GA24466@suse.de>
 <Pine.LNX.4.61.0409201220200.3460@scrub.home> <20040920105618.GB24928@suse.de>
 <Pine.LNX.4.61.0409201311050.3460@scrub.home> <20040920112607.GA19073@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 20 Sep 2004, Olaf Hering wrote:

> > > > How do you distinguish between manual and automatic loop device setup?
> > > 
> > > -v
> 
> What do you mean by auto vs. manual? I dont understand what you mean
> here.

$ mount -oloop image /mnt

vs

$ losetup image /dev/loop0
$ mount /dev/loop0 /mnt

What should umount do, when called with /mnt?

> > /dev/hda6 / ext3 rw 0 0
> 
> df should start with the last / entry. But this will work only if the
> chroot is on its own mount point, not if you chroot into a subdir of a
> mount point. It could just ignore the error.

Relying on any specifc ordering in /proc/mounts is broken.

bye, Roman
