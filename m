Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129737AbRAQQu5>; Wed, 17 Jan 2001 11:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130107AbRAQQur>; Wed, 17 Jan 2001 11:50:47 -0500
Received: from colorfullife.com ([216.156.138.34]:64264 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129737AbRAQQud>;
	Wed, 17 Jan 2001 11:50:33 -0500
Message-ID: <3A65CD48.92274EB0@colorfullife.com>
Date: Wed, 17 Jan 2001 17:50:16 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, alan@redhat.com, Steve.Ralston@lsil.com
Subject: 2.4.0-ac9: bug in drivers/message/fusion/mptctl.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AFAICS mptctl_lock() and mptctl_unlock() are just buggy implementations
of down() and up().

At least the 'current->state = TASK_UNINTERRUPTIBLE' must be moved into
the while(1) loop, or both function could be replaced with a semaphore.

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
