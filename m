Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310917AbSDDTmP>; Thu, 4 Apr 2002 14:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310637AbSDDTmG>; Thu, 4 Apr 2002 14:42:06 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:12476 "EHLO e1.esmtp.ibm.com")
	by vger.kernel.org with ESMTP id <S310917AbSDDTmA>;
	Thu, 4 Apr 2002 14:42:00 -0500
Message-ID: <3CACAC7A.4040209@us.ibm.com>
Date: Thu, 04 Apr 2002 11:41:46 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Linus Torvalds <torvalds@transmeta.com>,
        "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.8-pre1/kernel/exit.c change caused BUG() at
 boot time
In-Reply-To: <Pine.LNX.4.33.0204041113410.12895-100000@penguin.transmeta.com> <1017948383.22303.537.camel@phantasy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
>  	tsk->exit_code = code;
>  	exit_notify();
> +	preempt_enable_no_resched();
       * PREEMPT HERE *
>  	schedule();
>  	BUG();

Isn't there still a race here?  A preempt CAN happen after you reenable, 
right?  Admittedly, its a small window, but it _is_ a window.


-- 
Dave Hansen
haveblue@us.ibm.com

