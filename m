Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280481AbRKLJMM>; Mon, 12 Nov 2001 04:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280679AbRKLJMC>; Mon, 12 Nov 2001 04:12:02 -0500
Received: from wallext.webflex.nl ([212.115.150.250]:47028 "EHLO
	palm.webflex.nl") by vger.kernel.org with ESMTP id <S280481AbRKLJLz>;
	Mon, 12 Nov 2001 04:11:55 -0500
Message-ID: <XFMail.20011112101120.mathijs@webflex.nl>
X-Mailer: XFMail 1.5.1 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <878zdcl8eb.fsf@fadata.bg>
Date: Mon, 12 Nov 2001 10:11:20 +0100 (CET)
From: Mathijs Mohlmann <mathijs@webflex.nl>
To: Momchil Velikov <velco@fadata.bg>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix loop with disabled tasklets
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12-Nov-2001 Momchil Velikov wrote:
> In this patch, the first thing is to deschedule the tasklet. So, the
> changes to interrupt.h are needed in order to put back the tasklet in
> the queue.
I know, but Andrea suggested not to allow scheduling of disabled tasklets
Also, enableing the tasklet will result in a scheduled tasklet, regardless
whether it was scheduled. Plus, we are not sure if it is scheduled on the
same cpu that did the tasklet_schedule (but i might be the only one who
cares about this  ;)

> Mathijs> thisone we should add some comments to interrupt.h warning
> Mathijs> about deadlocks etc.
> What deadlocks ? ;)
well, loops. Dont use tasklet_kill on disabled tasklet or on not scheduled
tasklets.

        me


-- 
        me
