Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbVH2DzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbVH2DzQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 23:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbVH2DzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 23:55:16 -0400
Received: from [218.25.172.144] ([218.25.172.144]:63493 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S1750853AbVH2DzO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 23:55:14 -0400
Message-ID: <4312870E.9000708@fc-cn.com>
Date: Mon, 29 Aug 2005 11:54:54 +0800
From: qiyong <qiyong@fc-cn.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, dhommel@gmail.com
Subject: Re: syscall: sys_promote
References: <20050826092537.GA3416@localhost.localdomain>	 <20050826110226.GA5184@localhost.localdomain> <1125069558.4958.83.camel@localhost.localdomain>
In-Reply-To: <1125069558.4958.83.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Gwe, 2005-08-26 at 19:02 +0800, Coywolf Qi Hunt wrote:
>  
>
>>>3) admins can `promote' a suspect process instead of killing it.
>>>
>>>Is it also generally useful in practice?  Thoughts?
>>>      
>>>
>
>The locking is wrong. At the moment the entire kernel assumes that a
>process uid is not changed by anyone else. After you've implemented uid
>locking/refcounting for tasks you can add the syscall but until then its
>not a good idea. I don't think its a good idea anyway - selinux can do
>far more useful things.
>

Indeed. "Also it's not obvious that locking can be done right (or that 
anybody cares). "
We can ignore it safely.  sys_promote is a different approach from 
selinux.  sys_promote is to let sysadmin manually manipulate a running 
process,
