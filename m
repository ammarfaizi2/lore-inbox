Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265421AbTGKU4J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 16:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266774AbTGKU4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 16:56:09 -0400
Received: from catv-d5dea48a.bp11catv.broadband.hu ([213.222.164.138]:28676
	"EHLO domesticus.fery-local.hu") by vger.kernel.org with ESMTP
	id S265421AbTGKUzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 16:55:37 -0400
Message-ID: <3F0F27B6.9B7DAAE2@engard.hu>
Date: Fri, 11 Jul 2003 23:10:14 +0200
From: Ferenc Engard <ferenc@engard.hu>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Keyser Soze <keyser_soze2u@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Geode GX1, video acceleration -> crash
References: <20030711181025.14633.qmail@web10001.mail.yahoo.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keyser Soze wrote:
> 
> > But the real problem is, that I wanted to benchmark
> > the system while the scrolling continues, and issued
> > a dd if=/dev/mem of=/dev/null bs=1024 count=32768
> > command. For the second go, the system freezed like
> > a good refrigerator. No kernel panic, nothing, just
> > freezed.
> 
> Try turning off ide dma and see if that helps.  You
> will lose very little by turning off udma on this
> system and I'll bet you end up being more stable.

I will try it on Monday, as the eval board is in my workplace. What is
the connection between ide dma, memory read and the hw video accel? The
ide dma setting alters the way /dev/mem is read? :-O

I had a feeling that maybe it is a dma-related problem, but I do not
know what does 'dd if=/dev/mem......' _really_ do. It uses a dma
channel? The GX1 manual do not mention that the bitblk engine use up
dma; in fact, I do think that it is a serious design error that using
the bitlbk engine alters the way the memory can be used (except memory
bandwith usage, naturally). 

Anyway, if it solves the problem, I must understand why happened this
error. The product will be a medical bedside monitor; so it is not
enough that it is now _more_ stable, I have to know the origin of the
problem.

I can tell you more on Monday,
Circum

PS: The system will run from flash (on IDE controller), so I suspect
that it will be a _real big_ slowdown if in the last product I have to
turn of the dma, but hopefully there will be no gigabytes of data...

