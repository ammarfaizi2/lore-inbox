Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261971AbUL0USP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbUL0USP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 15:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbUL0USP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 15:18:15 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:13432 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261971AbUL0UOy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 15:14:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=UfteH2gvV2eQ5Ur0h2FI5vyye9Gq6ZQN/JrweI3Xp+6cH0T6ILZXt9NtZVH1bFvgdmO8r8C3lYBVlb8SG0XKLOqzC6fz93ykXdve1g8CxSF//WWNc65AiBUPJ/MyUbt4gVogkJukQsGc4rvnpAH6WRDPO4XfNr5OzXkD9Qa1BGM=
Message-ID: <d5a95e6d04122712148459507@mail.gmail.com>
Date: Mon, 27 Dec 2004 17:14:53 -0300
From: Diego <foxdemon@gmail.com>
Reply-To: Diego <foxdemon@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: About NFS4 in kernel 2.6.9
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0412272045020.9354@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <d5a95e6d04122711183596d0c8@mail.gmail.com>
	 <20041227192508.GC18869@freenet.de>
	 <d5a95e6d04122711355a0a9b04@mail.gmail.com>
	 <Pine.LNX.4.61.0412272045020.9354@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your help,
I´ve checked what Jan said, and in .config is NFS_FS=y. When i do
modprobe sunrpc shows me:

[root@laca01 ~]# modprobe sunrpc
FATAL: Module sunrpc not found.
FATAL: Error running install command for sunrpc

It´s really annoyng :)

On Mon, 27 Dec 2004 20:46:38 +0100 (MET), Jan Engelhardt
<jengelh@linux01.gwdg.de> wrote:
> >First sorry about my poor english. I read in internet that it´s best
> >if i recompile NFS4 as module, so i did it. But i have this error
> >message. I dont know wht to do. when i do make xconfig, in filesystem,
> >i have checked all that have NFS and RPC, but it insist in not work.
> 
> Really? I have this in fs/Kconfig (2.6.8+2.6.9-rc2):
> 
> menu "Network File Systems"
>        depends on NET
> 
> config NFS_FS
>        tristate "NFS file system support"
>        depends on INET
>        select LOCKD
>        select SUNRPC
>        select NFS_ACL_SUPPORT if NFS_ACL
> 
> So SUNRPC should always be selected whenever you say yes/module to "NFS file
> system support".
> Check the .config if NFS_FS=y or =m, that'd be my guess.
> 
> 
> Jan Engelhardt
> --
> ENOSPC
>
