Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318977AbSIIVFh>; Mon, 9 Sep 2002 17:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318976AbSIIVFh>; Mon, 9 Sep 2002 17:05:37 -0400
Received: from antigonus.hosting.pacbell.net ([216.100.98.13]:56252 "EHLO
	antigonus.hosting.pacbell.net") by vger.kernel.org with ESMTP
	id <S318975AbSIIVFT>; Mon, 9 Sep 2002 17:05:19 -0400
Reply-To: <imran.badr@cavium.com>
From: "Imran Badr" <imran.badr@cavium.com>
To: "'Manfred Spraul'" <manfred@colorfullife.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Calculating kernel logical address ..
Date: Mon, 9 Sep 2002 14:07:34 -0700
Message-ID: <01b101c25844$ebb7d8f0$9e10a8c0@IMRANPC>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <3D7D0C58.4000309@colorfullife.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Manfred Spraul [mailto:manfred@colorfullife.com]
Sent: Monday, September 09, 2002 2:02 PM
To: Imran Badr; linux-kernel@vger.kernel.org
Subject: RE: Calculating kernel logical address ..


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

>Wrong. Acquiring the mmap semaphore does NOT prevent the swapper from
>swapping out pages.

>Only the page_table_lock prevents the swapper from touching a task.

>--
>	Manfred


I think you missed the whole context of the discussion. The next step is to
call get_user_pages() which takes appropriate actions to prevent page swaps.

Thanks,
Imran.



