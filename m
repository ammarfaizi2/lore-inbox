Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283832AbRK3Xm7>; Fri, 30 Nov 2001 18:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283833AbRK3Xmt>; Fri, 30 Nov 2001 18:42:49 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:26630 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S283832AbRK3Xmd>; Fri, 30 Nov 2001 18:42:33 -0500
Date: Fri, 30 Nov 2001 15:53:02 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: lkml <linux-kernel@vger.kernel.org>,
        Shuji YAMAMURA <yamamura@flab.fujitsu.co.jp>
Subject: Re: [PATCH] task_struct colouring ...
In-Reply-To: <E169wL1-00052x-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0111301547130.1600-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2001, Alan Cox wrote:

> > Looking at both the Manfred and Fujitsu patches I propose this new version
> > for task struct colouring.
> > The patch from Manfred is too architecture dependent ( cr2 ) and storing
> > extra stuff in CPU registers is not IMHO a good idea.
>
> Well the whole "current" handling is entirely architecture dependant anyway.
> On most saner platforms current is a global register variable (the wonders
> of gcc) and the whole problem simply isnt there

So You like the idea of stocking structure pointers inside CPU registers
or I missed Your point ?
The proposed implementation is "uniform" between architectures, that's my
point.
What for CPUs that cannot offer "free" registers ?
What if someone else, following the example, start stocking some other
pointer in free registers ?




- Davide


