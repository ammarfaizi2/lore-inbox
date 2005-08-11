Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbVHKQX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbVHKQX5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 12:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbVHKQX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 12:23:57 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:14724 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S932297AbVHKQX4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 12:23:56 -0400
Message-ID: <42FB7B95.30702@gmail.com>
Date: Thu, 11 Aug 2005 18:23:49 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: hetfield666@gmail.com
CC: "Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.13-rc6-git3 undefined reference on _mntput
References: <42FB752D.6070101@gmail.com>
In-Reply-To: <42FB752D.6070101@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hetfield napsal(a):

> grep _mntput *
> namei.c:        _mntput(nd->mnt);
> namespace.c:void __mntput(struct vfsmount *mnt)
> namespace.c:EXPORT_SYMBOL(__mntput);
>
>
>  CC      fs/namei.o
> fs/namei.c: In function `path_release_on_umount':
> fs/namei.c:317: warning: implicit declaration of function `_mntput'

In 2.6.13-rc6-git3 there is nothing like that (nor on that line) and 
compiles for me.
Maybe you mispatched it, because in namei.c in that git there is 
mntput_no_expire(nd->mnt);, not _mntput.

regards,

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

