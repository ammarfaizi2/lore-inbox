Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbUL3CXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbUL3CXb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 21:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbUL3CXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 21:23:31 -0500
Received: from mail.tmr.com ([216.238.38.203]:52166 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261521AbUL3CX0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 21:23:26 -0500
Message-ID: <41D368F7.8090502@tmr.com>
Date: Wed, 29 Dec 2004 21:33:27 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Diego <foxdemon@gmail.com>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: About NFS4 in kernel 2.6.9
References: <Pine.LNX.4.61.0412272045020.9354@yvahk01.tjqt.qr><d5a95e6d04122711183596d0c8@mail.gmail.com> <d5a95e6d04122712148459507@mail.gmail.com>
In-Reply-To: <d5a95e6d04122712148459507@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego wrote:
> Thanks for your help,
> I´ve checked what Jan said, and in .config is NFS_FS=y. When i do
> modprobe sunrpc shows me:
> 
> [root@laca01 ~]# modprobe sunrpc
> FATAL: Module sunrpc not found.
> FATAL: Error running install command for sunrpc
> 
> It´s really annoyng :)
> 
> On Mon, 27 Dec 2004 20:46:38 +0100 (MET), Jan Engelhardt
> <jengelh@linux01.gwdg.de> wrote:
> 
>>>First sorry about my poor english. I read in internet that it´s best
>>>if i recompile NFS4 as module, so i did it. But i have this error
>>>message. I dont know wht to do. when i do make xconfig, in filesystem,
>>>i have checked all that have NFS and RPC, but it insist in not work.
>>
>>Really? I have this in fs/Kconfig (2.6.8+2.6.9-rc2):
>>
>>menu "Network File Systems"
>>       depends on NET
>>
>>config NFS_FS
>>       tristate "NFS file system support"
>>       depends on INET
>>       select LOCKD
>>       select SUNRPC
>>       select NFS_ACL_SUPPORT if NFS_ACL
>>
>>So SUNRPC should always be selected whenever you say yes/module to "NFS file
>>system support".
>>Check the .config if NFS_FS=y or =m, that'd be my guess.

By any chance was sunrpc compiled in instead of module? What is the 
setting in your .config file?

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
