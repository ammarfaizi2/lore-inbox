Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265681AbSKYVRt>; Mon, 25 Nov 2002 16:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265700AbSKYVRs>; Mon, 25 Nov 2002 16:17:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37393 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265681AbSKYVRr>;
	Mon, 25 Nov 2002 16:17:47 -0500
Date: Mon, 25 Nov 2002 21:25:02 +0000
From: Matthew Wilcox <willy@debian.org>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, Mark Wong <markw@osdl.org>
Subject: Re: [BUG] open file descriptors remain after threaded exit() in 2.5.44
Message-ID: <20021125212502.A10190@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


thanks for cc'ing the file locking maintainer or the linux-fsdevel
mailing lists.  you know, like it says in MAINTAINERS.  after all, if
you'd done that you might've got a reply telling you it's a known bug,
and even a workaround.  as it is, i have no idea what Dave Olien's email
address is, so i can't send him mail.

i have a patch, it passes the LTP when run on a local filesystem, but
not over NFS which is why I haven't publicised it yet.  Thanks to OSDL
for giving me access to machines to test this kind of thing on.

ftp://ftp.linux.org.uk/pub/linux/willy/patches/flock-2.5.49-2.diff

note, do not use NFS when using this patch.  really; i mean it.  somehow
i managed to corrupt thread_info.cpu causing _udelay_ to oops.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
