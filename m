Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129757AbRAWKf1>; Tue, 23 Jan 2001 05:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129826AbRAWKfR>; Tue, 23 Jan 2001 05:35:17 -0500
Received: from 213-120-138-140.btconnect.com ([213.120.138.140]:4868 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129757AbRAWKfE>;
	Tue, 23 Jan 2001 05:35:04 -0500
Date: Tue, 23 Jan 2001 10:36:36 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.1-pre8/10 klogd taking 100% of CPU time -- bug?
Message-ID: <Pine.LNX.4.21.0101231032080.1386-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Has anyone else seen this? The system load is 1.0 and all the cpu time is
taken by klogd but I do not have a stream of messages (or maybe I do but
they all are lost?). Also, kdb refuses to decode klogd's stack saying
"stack is not in task structure". It does show stack trace of other tasks
though.

So, since kdb was unable to tell me what's going on (and truss also can't
attach to it) one will have to debug it the old-fashioned way -- manually,
i.e. by trussing klogd from the beginning and reading it's sources...

Btw, this only happens on my laptop and not on the desktop. It only
happens _after_ some activity but I have not yet managed to narrow down
exactly what activity.

Regards,
Tigran

PS. No, I don't use power management or anything fancy/unproven like that
-- laptop is just a small/portable desktop, imho.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
