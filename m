Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318950AbSIIU5v>; Mon, 9 Sep 2002 16:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318951AbSIIU5v>; Mon, 9 Sep 2002 16:57:51 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:8108 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S318950AbSIIU5u>;
	Mon, 9 Sep 2002 16:57:50 -0400
Message-ID: <3D7D0C58.4000309@colorfullife.com>
Date: Mon, 09 Sep 2002 23:02:16 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "Imran Badr" <imran.badr@cavium.com>, linux-kernel@vger.kernel.org
Subject: RE: Calculating kernel logical address ..
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>As long as you can be sure they won't spontaneously vanish on you.
> 
>>--
>>Daniel
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 
> down(&current->mm->mmap_sem) would help.
> 

Wrong. Acquiring the mmap semaphore does NOT prevent the swapper from 
swapping out pages.

Only the page_table_lock prevents the swapper from touching a task.

--
	Manfred

