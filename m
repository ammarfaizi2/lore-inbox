Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWCRSsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWCRSsy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 13:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWCRSsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 13:48:54 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:40893 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750811AbWCRSsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 13:48:54 -0500
Message-ID: <441C55ED.6080702@us.ibm.com>
Date: Sat, 18 Mar 2006 13:48:13 -0500
From: Janak Desai <janak@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Oleg Nesterov <oleg@tv-sign.ru>, Andrew Morton <akpm@osdl.org>,
       ebiederm@xmission.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       viro@ftp.linux.org.uk, hch@lst.de, mtk-manpages@gmx.net, ak@muc.de,
       paulus@samba.org, Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH] for 2.6.16, disable unshare_vm()
References: <m1y7za9vy3.fsf@ebiederm.dsl.xmission.com>  <m1pskm9tz9.fsf@ebiederm.dsl.xmission.com>  <441AF596.F6E66BC9@tv-sign.ru> <20060317125607.78a5dbe4.akpm@osdl.org> <441C0741.3BC25010@tv-sign.ru> <441C2AA0.3080200@us.ibm.com> <441C4263.B779CDA8@tv-sign.ru> <441C4636.15F57F6@tv-sign.ru> <Pine.LNX.4.64.0603181007020.3826@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603181007020.3826@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Sat, 18 Mar 2006, Oleg Nesterov wrote:
>  
>
>>sys_unshare() does mmput(new_mm). This is not enough
>>if we have mm->core_waiters. This patch is a temporary
>>fix for soon to be released 2.6.16.
>>    
>>
>
>Yes. Quick raising of hands: is there anybody out there that expects to 
>use unshare(CLONE_VM) right now? One of the reasons it was integrated was 
>that I thought glibc wanted it for distros. Is disabling the CLONE_VM 
>unsharing going to impact that?
>
>		Linus
>
>  
>
We are using namespace and filesystem unsharing for our common criteria
certification work and would not be impacted by disabling of vm unsharing.

-Janak
