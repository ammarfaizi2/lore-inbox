Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264273AbRFGBJ6>; Wed, 6 Jun 2001 21:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264276AbRFGBJs>; Wed, 6 Jun 2001 21:09:48 -0400
Received: from pop.gmx.net ([194.221.183.20]:11957 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S264273AbRFGBJl>;
	Wed, 6 Jun 2001 21:09:41 -0400
Message-ID: <3B1ED233.CCF2942D@gmx.de>
Date: Thu, 07 Jun 2001 03:00:35 +0200
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: symlink_prefix
In-Reply-To: <Pine.GSO.4.21.0106030703590.27673-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
>         ...
>         dir = open("/usr/local", O_DIRECTORY);
>         /* error handling */
>         new_mount(dir, MNT_SET, fs_fd); /* closes dir and fs_fd */

Do you really want to start using fds instead of strings for tree
modifying commands (link, unlink, symlink, rename, mount and umount)?
Even if it were possible in the new_mount case it wouldn't have the
atomic lookup+act nature of the old mount.  And then, _I_ would
prefer a uniform interface for tree management commands - strings.

Ciao, ET.

