Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272008AbRH2QaA>; Wed, 29 Aug 2001 12:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272009AbRH2Q3u>; Wed, 29 Aug 2001 12:29:50 -0400
Received: from smtp.nwlink.com ([209.20.130.57]:11275 "EHLO smtp.nwlink.com")
	by vger.kernel.org with ESMTP id <S272008AbRH2Q3l>;
	Wed, 29 Aug 2001 12:29:41 -0400
From: "Jonathan Zimmerman" <tyrius@nwlink.com>
Reply-to: tyrius@nwlink.com
To: linux-kernel@vger.kernel.org
Date: Wed, 29 Aug 2001 09:29:55 -0700
Subject: softirq & schedule documentation
Message-id: <3b8d1887.44fb.0@nwlink.com>
X-User-Info: 141.202.246.17
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I'm in the process of trying to track down a problem with the sparc32 port

not booting and believe that the problem lies somewhere in either the scheduling

algorithm or ksoftirqd. Schedule is called by spawn_ksoftirqd, which then proceeds

to loop infinately. I know that, eventually, prev = current = next = ksoftirqd.

current->need_resched gets set to 0 in the move_rr_back block of schedule(),

but at some point in recalculate: it gets set back to 1.

Is there any sort of documentation on the softirq stuff and the scheduling algorithm

out there that is relevant to 2.4.9? It seems that the only stuff I've managed

to find is based off the 2.2.x kernels.

Thanks,

Jonathan Zimmerman
