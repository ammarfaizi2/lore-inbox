Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269153AbUJKQCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269153AbUJKQCH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 12:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269152AbUJKPyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 11:54:18 -0400
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:2447 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S269043AbUJKPvx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 11:51:53 -0400
Message-ID: <416AABC6.8040405@ru.mvista.com>
Date: Mon, 11 Oct 2004 19:50:30 +0400
From: "Eugeny S. Mints" <emints@ru.mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vadim Lebedev <vadim@mbdsys.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
References: <200410111728.39200.vadim@mbdsys.com>
In-Reply-To: <200410111728.39200.vadim@mbdsys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vadim Lebedev wrote:
> Sven-Thorsten Dietrich <sdietrich@mvista.com> wrote in message 
> news:<2Nir3-4iC-13@gated-at.bofh.it>...
> 
>>Announcing the availability of prototype real-time (RT)
>>enhancements to the Linux 2.6 kernel.
> 
> 
> Reading the sources i believe that __p_mutex_up  is not constant time
> operation because of __p_mutex_down....
> 
> It is clear that
> __p_mutex_down is not constant time operation because of insertion
> into the priority-sorted sleepers list.  However both __p_mutex_down
> and __p_mutex_up are synchronize on the same global spinlock
> (m_spin_lock) ....  so if the __p_mutex_down is holding this spinlock
> while inserting NO other process(or) is able to perform any __p_mutex
> operation...

Current pmutex implementation was chosen only as prototype 
implementation. kmutex abstraction layer allows to switch easily between 
any (alternative) mutex implementations and to choose optimal one on a 
benchmarking basis.

> 
> Maybe the better idea would be to have a per-mutex spinlock? or even
> better, given that the task->rt_priority have a finite range maybe each
> mutex can have a table of sleeper lists indexed by rt_priority?
> 
> 
> Vadim
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 


