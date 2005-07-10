Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbVGJDUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbVGJDUN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 23:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVGJDUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 23:20:13 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:15150 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261826AbVGJDUL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 23:20:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PxKFMOyWsHZFuQBXe6N4pC7GEuXjRjvRUlWUwGOkqx7hcEiskSbds8XbG3LjitkhA3wz/yNyI0+QdPZb9MqgmZPvRrvCtGxnmofIAMG8FABbkELxoPtB7xVS+vjST9zuHwgVPh8FPY3MW49wyymt+QM5BLHyfE7TwzkegfKQG+0=
Message-ID: <21d7e99705070920202fd6040b@mail.gmail.com>
Date: Sun, 10 Jul 2005 13:20:11 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: nboyle@tampabay.rr.com
Subject: Re: [BUG] Oops: EIP is at sysfs_release+0x34/0x80
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42D01096.8050601@tampabay.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42CEB851.1000004@tampabay.rr.com>
	 <20050708145001.34b9f8f2.akpm@osdl.org>
	 <20050708215518.GB21768@kroah.com> <42D01096.8050601@tampabay.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>
> >>
> >>>EIP is at sysfs_release+0x34/0x80
> >>>eax: 00000001   ebx: dc7c2000   ecx: d1979860   edx: 00000001
> >>>esi: 762f7373   edi: d5ba26a0   ebp: d9368544   esp: dc7c3f80
> >>>ds: 007b   es: 007b   ss: 0068
> >>>Process udev (pid: 31802, threadinfo=dc7c2000 task=c7c19040)
> >>>Stack: df468c40 df798140 dffe4140 c0153c08 d5a9edbc df468c40 df798140
> >>>00000000
> >>>        dc7c2000 c01523d3 00000000 00000003 080ac568 00000003 c0103101
> >>>00000003
> >>>        080ac568 00000004 080ac568 00000003 08057198 00000006 0000007b
> >>>0000007b
> >>>Call Trace:
> >>>  [<c0153c08>] __fput+0xf8/0x110
> >>>  [<c01523d3>] filp_close+0x43/0x70
> >>>  [<c0103101>] syscall_call+0x7/0xb
> >>>Code: 8b 41 0c 8b 40 48 8b 58 14 8b 41 48 8b 40 14 85 db 8b 70 04 74 07
> >>>89 d8 e8 9a 11 02 00 85 f6 74 1f bb 00 e0 ff ff 21 e3 ff 43 14 <ff> 8e
> >>>00 01 00 00 83 3e 02 74 32 8b 43 08 ff 4b 14 a8 08 75 21
> >>>  <6>note: udev[31802] exited with preempt_count 1
> >>>
> >>>
> >>Gee we get a lot of these, and no idea which sysfs file caused it.
> >>
> >>How about we record the most-recently-opened sysfs file and display that at
> >>oops time?  (-mm only)
> >>

> >
> >Looks good to me, I really have no idea of what is causing this, and
> >haven't seen any reports of this on mainline.
> >
> >thanks,
> >
> >greg k-h
> >
> >
> >
> Actually, I'm running a kernel straight from Linus' GIT repository.
> EFLAGS: 00010202   (2.6.13-rc2-GIT-08-7-2005-0)
> 

I can't reproduce (nothing new there...) if you can test with  the
patch Andrew suggested, and let us know what occurs.. I thought this
was DRM related from another report but maybe he just had two bugs
(one DRM related misconfiguration, and something else)..

Dave.
