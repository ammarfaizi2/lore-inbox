Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbVACOD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbVACOD4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 09:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVACOD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 09:03:56 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:58832 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261452AbVACODw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 09:03:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Hhmv6D3QBF8UE/3My44KvrubQDENV+8Eun27lG5N1vm8z+2wmKW9qYNv0b0DUuYumJ5HMcrzZNml9bcz96oDy4vOJ0CnTMg7CRWMdVhH+zjOUHty459WtChttAlq4HNRLbMP/kAJ+3gAKv5CW05ODoSyGhI4laOTLpaviZBcH/c=
Message-ID: <d5a95e6d050103060322f0cbc@mail.gmail.com>
Date: Mon, 3 Jan 2005 11:03:49 -0300
From: Diego <foxdemon@gmail.com>
Reply-To: Diego <foxdemon@gmail.com>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: About NFS4 in kernel 2.6.9
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
In-Reply-To: <41D368F7.8090502@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <Pine.LNX.4.61.0412272045020.9354@yvahk01.tjqt.qr>
	 <d5a95e6d04122711183596d0c8@mail.gmail.com>
	 <d5a95e6d04122712148459507@mail.gmail.com> <41D368F7.8090502@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for all help, finally it´s working
 I prayed to lord, enjoy the 2004=>2005 and it worked. I think i was
doing something wrong heheh.
Thanks to all again.

On Wed, 29 Dec 2004 21:33:27 -0500, Bill Davidsen <davidsen@tmr.com> wrote:
> Diego wrote:
> > Thanks for your help,
> > I´ve checked what Jan said, and in .config is NFS_FS=y. When i do
> > modprobe sunrpc shows me:
> >
> > [root@laca01 ~]# modprobe sunrpc
> > FATAL: Module sunrpc not found.
> > FATAL: Error running install command for sunrpc
> >
> > It´s really annoyng :)
> >
> > On Mon, 27 Dec 2004 20:46:38 +0100 (MET), Jan Engelhardt
> > <jengelh@linux01.gwdg.de> wrote:
> >
> >>>First sorry about my poor english. I read in internet that it´s best
> >>>if i recompile NFS4 as module, so i did it. But i have this error
> >>>message. I dont know wht to do. when i do make xconfig, in filesystem,
> >>>i have checked all that have NFS and RPC, but it insist in not work.
> >>
> >>Really? I have this in fs/Kconfig (2.6.8+2.6.9-rc2):
> >>
> >>menu "Network File Systems"
> >>       depends on NET
> >>
> >>config NFS_FS
> >>       tristate "NFS file system support"
> >>       depends on INET
> >>       select LOCKD
> >>       select SUNRPC
> >>       select NFS_ACL_SUPPORT if NFS_ACL
> >>
> >>So SUNRPC should always be selected whenever you say yes/module to "NFS file
> >>system support".
> >>Check the .config if NFS_FS=y or =m, that'd be my guess.
> 
> By any chance was sunrpc compiled in instead of module? What is the
> setting in your .config file?
> 
> --
> bill davidsen <davidsen@tmr.com>
>   CTO TMR Associates, Inc
>   Doing interesting things with small computers since 1979
>
