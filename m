Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132359AbRDJWDa>; Tue, 10 Apr 2001 18:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132370AbRDJWDU>; Tue, 10 Apr 2001 18:03:20 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:61192 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132359AbRDJWDE>; Tue, 10 Apr 2001 18:03:04 -0400
Subject: Re: kswapd, kupdated, and bdflush at 99% under intense IO
To: phil@theoesters.com (Phil Oester)
Date: Tue, 10 Apr 2001 23:05:05 +0100 (BST)
Cc: Jeff.Lessem@Colorado.EDU (Jeff Lessem), linux-kernel@vger.kernel.org
In-Reply-To: <LAEOJKHJGOLOPJFMBEFEKEOBDDAA.phil@theoesters.com> from "Phil Oester" at Apr 10, 2001 01:25:06 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14n6G4-0005JO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Any time I start injecting lots of mail into the qmail queue, *one* of the
> two processors gets pegged at 99%, and it takes forever for anything typed
> at the console to actually appear (just as you describe).  But I don't see

Yes I've seen this case. Its partially still a mystery

> Upon powercycling, the qmail partition is loaded with thousands of errors -
> which could be caused by the power cycling, or by something kernel related.

Under heavy I/O loads the cerberus test suite has been showing real disk
corruption on all current trees until Ingo's patch today to fix the ext2
and minix problems combined with the earlier fixes for other races

In your case I suspect its the qmail thousands of files being created/deleted
not the corruption but its hard to be sure

