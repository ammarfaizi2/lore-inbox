Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288748AbSC0VFu>; Wed, 27 Mar 2002 16:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288012AbSC0VFk>; Wed, 27 Mar 2002 16:05:40 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:50146 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S287631AbSC0VF1>; Wed, 27 Mar 2002 16:05:27 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Rusty Russell <rusty@rustcorp.com.au>, Martin Wirth <martin.wirth@dlr.de>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
Date: Wed, 27 Mar 2002 16:05:51 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Peter =?iso-8859-1?q?W=E4chtler?= <pwaechtler@loewe-komp.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <E16q059-00088e-00@wagner.rustcorp.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020327210454.BBB763FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 March 2002 06:10 pm, Rusty Russell wrote:
> In message <3CA02E80.1000600@dlr.de> you write:
> > >   And on top of them:
> > >   futex_down(struct futex *);
> > >   futex_up(struct futex *);
> >
> > Why not keep the simple one-sys-call interface for the fuxtexes. The
> > code is so small that it is
> >  not worth to delete it.
>
>

Rusty, you lost me in all these discussions now.
Is the current position to export wait queues and drop the futex interface ?
I would recommend against that. If we need 2 syscalls to implement
the futex behavior that certainly will create quite some overhead.

>From my own implementation, I exported the wait queues and I didn't need the
add/wait sequence. This as you know is/was due to the fact that I used 
semaphores in the kernel. While that created some allocation problems and 
won't allow for usage of the wait queues, it seems more compact.
Any chance to move the semaphore behavior into the futexes.



-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
