Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267496AbRGMQHs>; Fri, 13 Jul 2001 12:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267498AbRGMQHi>; Fri, 13 Jul 2001 12:07:38 -0400
Received: from mail1.qualcomm.com ([129.46.64.223]:61165 "EHLO
	mail1.qualcomm.com") by vger.kernel.org with ESMTP
	id <S267496AbRGMQHW>; Fri, 13 Jul 2001 12:07:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Maksim Krasnyanskiy <maxk@qualcomm.com>
Organization: Qualcomm
To: jreuter@suse.de (Joerg Reuter)
Subject: Re: [BUG?] vtund broken by tun driver changes in 2.4.6
Date: Fri, 13 Jul 2001 08:58:52 -0700
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.33.0107070058350.29490-100000@mackman.net.suse.lists.linux.kernel> <009601c106ff$a3cb2070$6baaa8c0@kevin.suse.lists.linux.kernel> <20010713133329.DDCEB19A57@lamarr.suse.de>
In-Reply-To: <20010713133329.DDCEB19A57@lamarr.suse.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01071308585200.00792@btdemo1.qualcomm.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Recompile your VTUND daemon with the new kernel headers (and also updated
> > to 2.5 vtund, it has some small patches) and you will be fine.
>
> Probably not:
>
>         #define TUNSETNOCSUM  _IOW('T', 200, int)
>         #define TUNSETDEBUG   _IOW('T', 201, int)
>         #define TUNSETIFF     _IOW('T', 202, int)
>         #define TUNSETPERSIST _IOW('T', 203, int)
>         #define TUNSETOWNER   _IOW('T', 204, int)
>
> Which is (apart from some extensions) the same as it ever was. However adding a
Ioctls were defined _without_ IOW macros. And that was ugly. That's why I redifened them.
So, if you recompile everything will be fine.

> And BTW, you shouldn't include kernel headers from user space programs, should you.
That rule doesn't apply here. 

Max 

-- 

Maksim Krasnyanskiy      
Senior Kernel Engineer
Qualcomm Incorporated

maxk@qualcomm.com
http://bluez.sf.net
http://vtun.sf.net
