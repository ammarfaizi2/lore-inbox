Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbTITSza (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 14:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbTITSz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 14:55:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:53896 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261940AbTITSz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 14:55:28 -0400
Date: Sat, 20 Sep 2003 11:56:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Weber <shawk@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5-mm3 VFAT File system problem
Message-Id: <20030920115647.5d1abfba.akpm@osdl.org>
In-Reply-To: <1064081224.6093.5.camel@athxp.bwlinux.de>
References: <1064081224.6093.5.camel@athxp.bwlinux.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Weber <shawk@gmx.net> wrote:
>
> I can confirm this behavior. 
> 
>  I checked my fstab entry. Was saying:
> 
>  /dev/hda5               /mnt/windows/D  vfat            rw,user,umask=0
>  0 0
> 
>  After changing it to
>  /dev/hda5               /mnt/windows/D  vfat           
>  rw,user,uid=1001,gid=100 0 0
> 
>  I got it working again half of the time. Its strange. Sometimes I get
>  the message that only root can unmount it, even when I mounted it as
>  user. 
> 
>  Something is a little whacky there.

Any mount option of the form `foo=0' will fail, because the parser is
treating zero as an error.

I'll fix that up for -mm4, thanks.
