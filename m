Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQJ0DLW>; Thu, 26 Oct 2000 23:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129102AbQJ0DLM>; Thu, 26 Oct 2000 23:11:12 -0400
Received: from suntan.tandem.com ([192.216.221.8]:11980 "EHLO Tandem.com")
	by vger.kernel.org with ESMTP id <S129091AbQJ0DLG>;
	Thu, 26 Oct 2000 23:11:06 -0400
Message-ID: <39F8F06B.B77E30A1@compaq.com>
Date: Thu, 26 Oct 2000 20:03:07 -0700
From: "Brian J. Watson" <Brian.J.Watson@compaq.com>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.2.12-20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anonymous <anonymos@micron.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: scheduler
In-Reply-To: <006901c03e4a$9c48e9a0$53b613d1@micron.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anonymous wrote:
> 
> In redhat where is the process scheduler located? Does this scheduler
> implement round robin?


It doesn't matter whether it's RedHat, or any other distribution.
They're all the same kernel.

Look at schedule() in kernel/sched.c to see the heart of the scheduler.
My understanding is that it's a weighted round robiner, considering such
things as the nice value and how often a process gets caught "holding
the ball" by the clock interrupt.

Hope this helps.


-Brian
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
