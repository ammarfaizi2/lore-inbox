Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287858AbSCKSkq>; Mon, 11 Mar 2002 13:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288012AbSCKSk1>; Mon, 11 Mar 2002 13:40:27 -0500
Received: from ithilien.qualcomm.com ([129.46.51.59]:37823 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S287425AbSCKSkU>; Mon, 11 Mar 2002 13:40:20 -0500
Message-Id: <5.1.0.14.2.20020311103743.051b0700@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 11 Mar 2002 10:38:47 -0800
To: Francois Romieu <romieu@cogenit.fr>
From: Maksim Krasnyanskiy <maxk@qualcomm.com>
Subject: Re: [PATCH] ATM locking fix. [Re: [PATCH] spinlock not locked
  when unlocking in atm_dev_register]
Cc: Robert Love <rml@tech9.net>, Frode Isaksen <fisaksen@bewan.com>,
        mitch@sfgoth.com, linux-kernel@vger.kernel.org,
        marcelo Tosatti <marcelo@conectiva.com.br>, alan@lxorguk.ukuu.org.uk
In-Reply-To: <20020309194515.B6626@fafner.intra.cogenit.fr>
In-Reply-To: <5.1.0.14.2.20020307141124.084dbde8@mail1.qualcomm.com>
 <5.1.0.14.2.20020307141124.084dbde8@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>- dev = NULL is to be inserted between (A) and (B) or the caller won't
>   notice the failure
Oops. Missed that one.

>- atm_proc_dev_register issues kmalloc(...,GFP_KERNEL) and atm_dev_lock
>   is hold
No. It uses GFP_ATOMIC.

Max

