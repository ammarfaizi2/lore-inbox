Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267708AbTB1JPP>; Fri, 28 Feb 2003 04:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267736AbTB1JPP>; Fri, 28 Feb 2003 04:15:15 -0500
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:37863 "EHLO
	d12lmsgate-4.de.ibm.com") by vger.kernel.org with ESMTP
	id <S267708AbTB1JPO>; Fri, 28 Feb 2003 04:15:14 -0500
Importance: Normal
Sensitivity: 
Subject: Re: [PATCH] 2.5.63 tsk->usage count.
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFF53DE423.F325007B-ONC1256CDB.0031AB85@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Fri, 28 Feb 2003 10:24:03 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 28/02/2003 10:25:16
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This actually looks wrong, it ends up doing free_user() twice because a
> final put_task_struct() does that too these days.
>
> Does this alternate patch work for you instead?

Works fine. I had a "Badness in __put_task_struct at kernel/fork.c:77"
from time to time. I couldn't reproduce this with your patch.

blue skies,
   Martin


