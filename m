Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273902AbRI0VH3>; Thu, 27 Sep 2001 17:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273908AbRI0VHT>; Thu, 27 Sep 2001 17:07:19 -0400
Received: from t2.redhat.com ([199.183.24.243]:58352 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S273902AbRI0VHF>; Thu, 27 Sep 2001 17:07:05 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3BB38D4E.5000100@switchmanagement.com> 
In-Reply-To: <3BB38D4E.5000100@switchmanagement.com>  <20010927141238.E5125@crb-web.com> 
To: Brian Strand <bstrand@switchmanagement.com>
Cc: Wayne Cuddy <wcuddy@crb-web.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronization Techniques in 2.2 Kernel 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 27 Sep 2001 22:07:24 +0100
Message-ID: <19474.1001624844@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


bstrand@switchmanagement.com said:
> I apologize in advance if this is not quite right, having only done
> "hello world" kernel modules thus far (plus a good deal of kernel
> source  browsing).  I think you need to "unfold" the
> interruptible_sleep_on call  and do it yourself by adding current to
> the wait queue before checking  any cards, setting current->state =
> TASK_INTERRUPTIBLE, then checking  all cards and if none has data,
> calling schedule.

You're right. It is very difficult to use sleep_on() and friends safely, 
and for that reason the plan is (or at least _has_ been) to take them all 
away in 2.5.



--
dwmw2


