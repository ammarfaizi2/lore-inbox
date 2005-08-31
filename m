Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932471AbVHaH6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbVHaH6v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 03:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbVHaH6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 03:58:50 -0400
Received: from [218.25.172.144] ([218.25.172.144]:47366 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S932471AbVHaH6u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 03:58:50 -0400
Message-ID: <43156337.9090406@fc-cn.com>
Date: Wed, 31 Aug 2005 15:58:47 +0800
From: Qi Yong <qiyong@fc-cn.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, dhommel@gmail.com
Subject: Re: syscall: sys_promote
References: <20050826092537.GA3416@localhost.localdomain>	 <20050826110226.GA5184@localhost.localdomain>	 <1125069558.4958.83.camel@localhost.localdomain>	 <4312870E.9000708@fc-cn.com> <1125318568.23946.15.camel@localhost.localdomain>
In-Reply-To: <1125318568.23946.15.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Llu, 2005-08-29 at 11:54 +0800, qiyong wrote:
>  
>
>>We can ignore it safely.  sys_promote is a different approach from 
>>selinux.  sys_promote is to let sysadmin manually manipulate a running 
>>process,
>>    
>>
>
>You can ignore the patch easily enough. Ignoring the locking doesn't
>work because functionality like fork process counting, exec, and setuid
>all make definite assumptions that are not safe to tamper without unless
>you fix the uid locking.
>  
>

Will this be helpful?

kill -STOP $pid
promote $pid
kill -CONT $pid

>Fixing it might be useful in some obscure cases anyway - POSIX threads
>might benefit from it too, providing the functionality of changing all
>thread uids at once isnt triggered for sensible threaded app behaviour.
>
>
>  
>

