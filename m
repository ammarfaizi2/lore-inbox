Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132044AbRDPUEv>; Mon, 16 Apr 2001 16:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132045AbRDPUEm>; Mon, 16 Apr 2001 16:04:42 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:56301 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S132044AbRDPUE0>; Mon, 16 Apr 2001 16:04:26 -0400
Message-ID: <3ADB4F19.D5124F40@uow.edu.au>
Date: Mon, 16 Apr 2001 12:59:21 -0700
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John Fremlin <chief@bandits.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [new PATCH] Re: 8139too: defunct threads
In-Reply-To: <Pine.LNX.4.33.0104150100210.13758-100000@dystopia.lab43.org>
		<3AD99CE4.E1ED7090@colorfullife.com> <3ADB2522.6A0C579C@uow.edu.au>,
		Andrew Morton's message of "Mon, 16 Apr 2001 10:00:18 -0700" <m2u23ows1j.fsf@boreas.yi.org.>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Fremlin wrote:
> 
> 
> > So it seems that we must reparent the thread to init, and
> > make sure that it delivers SIGCHLD to init when it exits.
> 
> Sounds good. Why isn't SIGCHLD a stronger default anyway.

mm?   The caller gets to choose...

> [...]
> 
> > +     /* Set the exit signal to SIGCHLD so we signal init on exit */
> > +     if (this_task->exit_signal ! 0) {
> 
> Tyop.

aargh.  Thanks.  So that's what `cvs commit' does :)

The patch is OK with this converted into `!='.  But I'll
refresh and retest for tomorrow.  Still not very happy with
this approach though...
