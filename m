Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291732AbSBHSzq>; Fri, 8 Feb 2002 13:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291733AbSBHSze>; Fri, 8 Feb 2002 13:55:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50950 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291732AbSBHSzQ>;
	Fri, 8 Feb 2002 13:55:16 -0500
Message-ID: <3C641EE9.9F31612E@zip.com.au>
Date: Fri, 08 Feb 2002 10:54:33 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Martin Wirth <Martin.Wirth@dlr.de>, Robert Love <rml@tech9.net>,
        linux-kernel@vger.kernel.org, mingo@elte.hu, haveblue@us.ibm.com
Subject: Re: [RFC] New locking primitive for 2.5
In-Reply-To: <3C641511.9555ED47@dlr.de> <Pine.LNX.4.33.0202081201540.10896-100000@athlon>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 8 Feb 2002, Martin Wirth wrote:
> >
> > There are currently several attempts discussed to push out the
> > BKL and replace it by a semaphore e.g. the next step Robert Love
> > planned for his ll_seek patch (replace the BKL by inode i_sem).
> 
> But that won't have any contention anyway, so it's a non-issue.
> 

Yesterday, Ingo said:

> i think one example *could* be to turn inode->i_sem into a combi-lock. Eg.
> generic_file_llseek() could use the spin variant.
>
> this is a real performance problem, i've seen scheduling storms in
> dbench-type runs due to llseek taking the inode semaphore.

-
