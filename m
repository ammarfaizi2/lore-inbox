Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264677AbSKRXVR>; Mon, 18 Nov 2002 18:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265523AbSKRXVR>; Mon, 18 Nov 2002 18:21:17 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:16885 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265517AbSKRXVO>;
	Mon, 18 Nov 2002 18:21:14 -0500
Message-ID: <3DD97729.5040803@us.ibm.com>
Date: Mon, 18 Nov 2002 15:26:33 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, rml@tech9.net, riel@surriel.com,
       Davide Libenzi <davidel@xmailserver.org>
Subject: Re: unusual scheduling performance
References: <20021118081854.GJ23425@holomorphy.com> <705474709.1037608454@[10.10.2.3]> <20021118165316.GK23425@holomorphy.com> <3DD92914.1060301@us.ibm.com> <20021118201748.GL23425@holomorphy.com> <3DD96EE6.1080603@us.ibm.com> <3DD97336.40326A65@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Dave Hansen wrote:
>>kksymoops is broken, so:
>>dmesg | tail -20 | sort | uniq | ksymoops -m /boot/System.map
>>
>>Trace; c01c5757 <rwsem_down_write_failed+27/170>
>>Trace; c01220c6 <update_wall_time+16/50>
>>Trace; c01223ee <do_timer+2e/c0>
>>Trace; c0166bd3 <.text.lock.eventpoll+6/f3>
>>Trace; c0146568 <__fput+18/c0>
>>Trace; c010ae9a <handle_IRQ_event+2a/60>
>>Trace; c0144a05 <filp_close+85/b0>
>>Trace; c0144a8d <sys_close+5d/70>
>>Trace; c0108fab <syscall_call+7/b>
>>
> 
> So it would appear that eventpoll_release() is the problem.
> How odd.  You're not actually _using_ epoll there, are you?

Not unless grep uses epoll.

-- 
Dave Hansen
haveblue@us.ibm.com

