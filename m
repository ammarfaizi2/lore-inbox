Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263032AbRE1L3j>; Mon, 28 May 2001 07:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263034AbRE1L3b>; Mon, 28 May 2001 07:29:31 -0400
Received: from t111.niisi.ras.ru ([193.232.173.111]:29703 "EHLO
	t111.niisi.ras.ru") by vger.kernel.org with ESMTP
	id <S263032AbRE1L3N>; Mon, 28 May 2001 07:29:13 -0400
Message-ID: <3B12A5DE.7020408@niisi.msk.ru>
Date: Mon, 28 May 2001 15:24:14 -0400
From: Alexandr Andreev <andreev@niisi.msk.ru>
Organization: niisi
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3 i686; en-US; rv:0.9) Gecko/20010507
X-Accept-Language: ru, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Disabling interrupts before block device request call
In-Reply-To: <3B0EE8CF.7040502@niisi.msk.ru> <20010526000119.A23273@suse.de>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote

>
>Even with dropping io_request_lock, it's not recommended to sleep inside
>the request_fn. WIth plugging, you are basically preventing the other
>plugged queues from being run until you return.
>
>You could use a timer or similar to call you on a specified timeout
>instead.
>
Does it mean, that if i need timer interrupts in my block device driver, 
i need to do sti() instead of unlock io_request_lock? Is there any 
common rule for device drivers in such case?



