Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270701AbTGUT3M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 15:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270702AbTGUT3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 15:29:12 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:47076 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S270701AbTGUT3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 15:29:04 -0400
Date: Mon, 21 Jul 2003 16:40:27 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Chris Mason <mason@suse.com>,
       riel@redhat.com, lkml <linux-kernel@vger.kernel.org>,
       maillist@jg555.com
Subject: Re: Bug Report: 2.4.22-pre5: BUG in page_alloc (fwd)
In-Reply-To: <20030721212453.4139a217.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.55L.0307211624410.26518@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0307150859130.5146@freak.distro.conectiva>
 <1058297936.4016.86.camel@tiny.suse.com> <Pine.LNX.4.55L.0307160836270.30825@freak.distro.conectiva>
 <20030718112758.1da7ab03.skraw@ithnet.com> <20030721162033.GA4677@x30.linuxsymposium.org>
 <20030721212453.4139a217.skraw@ithnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 21 Jul 2003, Stephan von Krawczynski wrote:

> On Mon, 21 Jul 2003 12:20:33 -0400
> Andrea Arcangeli <andrea@suse.de> wrote:
>
> > > I managed to freeze the pre7 box within these few hours. There was no nfs
> > > involved, only tar-to-tape.
> > > I switched back to 2.4.21 to see if it is still stable.
> > > Is there a possibility that the i/o-scheduler has another flaw somewhere
> > > (just like during mount previously) ...
> >
> > is it a scsi tape?
>
> yes.
>
> > Is the tape always involved?
>
> No, I experience both freeze during nfs-only action and freeze during
> tar-to-scsi-tape.
> My feelings are that the freeze does (at least in the nfs case) not happen
> during high load but rather when load seems relatively light. Handwaving one
> could say it looks rather like an I/O sched starvation issue than breakdown
> during high load. Similar to the last issue.
>
> > there are st.c updates
> > between 2.4.21 to 22pre7. you can try to back them out.
>
> Hm, which?
>
> > [...]
> > You should also provide a SYSRQ+P/T of the hang or we can't debug it at
> > all.
>
> Well, I really tried hard to produce something, but failed so far, if I had
> more time I would try a serial console hoping that it survives long enough to
> show at least _something_.
> The only thing I ever could see was the BUG in page-alloc thing from the
> beginning of this thread.

Stephan,

I'm sending you the scsi tape driver changes in 2.4.22-pre so you can
revert them (in private in a few minutes).

If that doesnt make us spot the problem, can you PLEASE find out in which
-pre the problem starts ?

Thank you
