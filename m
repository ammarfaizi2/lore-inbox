Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130897AbRAIVlG>; Tue, 9 Jan 2001 16:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131157AbRAIVk4>; Tue, 9 Jan 2001 16:40:56 -0500
Received: from maild.telia.com ([194.22.190.3]:48647 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id <S130897AbRAIVko>;
	Tue, 9 Jan 2001 16:40:44 -0500
Content-Type: text/plain; charset=US-ASCII
From: Roger Larsson <roger.larsson@norran.net>
To: Anton Blanchard <anton@linuxcare.com.au>,
        Tobias Ringstrom <tori@tellus.mine.nu>
Subject: Re: Benchmarking 2.2 and 2.4 using hdparm and dbench 1.1
Date: Tue, 9 Jan 2001 22:36:21 +0100
X-Mailer: KMail [version 1.2]
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010105004644.K13759@linuxcare.com> <Pine.LNX.4.21.0101041940490.5827-100000@svea.tellus> <20010109220810.K662@linuxcare.com>
In-Reply-To: <20010109220810.K662@linuxcare.com>
MIME-Version: 1.0
Message-Id: <01010922362101.01377@dox>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 January 2001 12:08, Anton Blanchard wrote:
> > Where is the size defined, and is it easy to modify?
>
> Look in fs/buffer.c:buffer_init()
>
> > I noticed that /proc/sys/vm/freepages is not writable any more.  Is there
> > any reason for this?
>
> I am not sure why.
>

It can probably be made writeable, within limits (caused by zones...)

But the interesting part is that 2.4 tries to estimate how much memory it 
will need shortly (inactive_target) and try to keep that amount inactive 
clean (inactive_clean) - clean inactive memory can be freed and reused very
quickly.

cat /proc/meminfo

My feeling is that, for now, keeping it untuneable can help us in finding 
fixable cases...

/RogerL

--
Home page:
  http://www.norran.net/nra02596/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
