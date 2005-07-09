Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbVGIR7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbVGIR7y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 13:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbVGIR7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 13:59:53 -0400
Received: from ms-smtp-02-smtplb.tampabay.rr.com ([65.32.5.132]:52906 "EHLO
	ms-smtp-02.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S261645AbVGIR7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 13:59:53 -0400
Message-ID: <42D01096.8050601@tampabay.rr.com>
Date: Sat, 09 Jul 2005 13:59:50 -0400
From: Nathan Boyle <nboyle@tampabay.rr.com>
Reply-To: nboyle@tampabay.rr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050514
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Oops: EIP is at sysfs_release+0x34/0x80
References: <42CEB851.1000004@tampabay.rr.com> <20050708145001.34b9f8f2.akpm@osdl.org> <20050708215518.GB21768@kroah.com>
In-Reply-To: <20050708215518.GB21768@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Fri, Jul 08, 2005 at 02:50:01PM -0700, Andrew Morton wrote:
>  
>
>>Nathan Boyle <nboyle@tampabay.rr.com> wrote:
>>    
>>
>>>EIP is at sysfs_release+0x34/0x80
>>>eax: 00000001   ebx: dc7c2000   ecx: d1979860   edx: 00000001
>>>esi: 762f7373   edi: d5ba26a0   ebp: d9368544   esp: dc7c3f80
>>>ds: 007b   es: 007b   ss: 0068
>>>Process udev (pid: 31802, threadinfo=dc7c2000 task=c7c19040)
>>>Stack: df468c40 df798140 dffe4140 c0153c08 d5a9edbc df468c40 df798140
>>>00000000
>>>        dc7c2000 c01523d3 00000000 00000003 080ac568 00000003 c0103101
>>>00000003
>>>        080ac568 00000004 080ac568 00000003 08057198 00000006 0000007b
>>>0000007b
>>>Call Trace:
>>>  [<c0153c08>] __fput+0xf8/0x110
>>>  [<c01523d3>] filp_close+0x43/0x70
>>>  [<c0103101>] syscall_call+0x7/0xb
>>>Code: 8b 41 0c 8b 40 48 8b 58 14 8b 41 48 8b 40 14 85 db 8b 70 04 74 07
>>>89 d8 e8 9a 11 02 00 85 f6 74 1f bb 00 e0 ff ff 21 e3 ff 43 14 <ff> 8e
>>>00 01 00 00 83 3e 02 74 32 8b 43 08 ff 4b 14 a8 08 75 21
>>>  <6>note: udev[31802] exited with preempt_count 1
>>>      
>>>
>>Gee we get a lot of these, and no idea which sysfs file caused it.
>>
>>How about we record the most-recently-opened sysfs file and display that at
>>oops time?  (-mm only)
>>    
>>
>
>Looks good to me, I really have no idea of what is causing this, and
>haven't seen any reports of this on mainline.
>
>thanks,
>
>greg k-h
>
>  
>
Actually, I'm running a kernel straight from Linus' GIT repository.
EFLAGS: 00010202   (2.6.13-rc2-GIT-08-7-2005-0)

