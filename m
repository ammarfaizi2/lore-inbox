Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270659AbTGUTJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 15:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270667AbTGUTJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 15:09:57 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:63130 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S270659AbTGUTJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 15:09:53 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Mon, 21 Jul 2003 21:24:53 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: marcelo@conectiva.com.br, mason@suse.com, riel@redhat.com,
       linux-kernel@vger.kernel.org, maillist@jg555.com
Subject: Re: Bug Report: 2.4.22-pre5: BUG in page_alloc (fwd)
Message-Id: <20030721212453.4139a217.skraw@ithnet.com>
In-Reply-To: <20030721162033.GA4677@x30.linuxsymposium.org>
References: <Pine.LNX.4.55L.0307150859130.5146@freak.distro.conectiva>
	<1058297936.4016.86.camel@tiny.suse.com>
	<Pine.LNX.4.55L.0307160836270.30825@freak.distro.conectiva>
	<20030718112758.1da7ab03.skraw@ithnet.com>
	<20030721162033.GA4677@x30.linuxsymposium.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jul 2003 12:20:33 -0400
Andrea Arcangeli <andrea@suse.de> wrote:

> > I managed to freeze the pre7 box within these few hours. There was no nfs
> > involved, only tar-to-tape.
> > I switched back to 2.4.21 to see if it is still stable.
> > Is there a possibility that the i/o-scheduler has another flaw somewhere
> > (just like during mount previously) ...
> 
> is it a scsi tape?

yes.

> Is the tape always involved?

No, I experience both freeze during nfs-only action and freeze during
tar-to-scsi-tape.
My feelings are that the freeze does (at least in the nfs case) not happen
during high load but rather when load seems relatively light. Handwaving one
could say it looks rather like an I/O sched starvation issue than breakdown
during high load. Similar to the last issue.

> there are st.c updates
> between 2.4.21 to 22pre7. you can try to back them out.

Hm, which?

> [...]
> You should also provide a SYSRQ+P/T of the hang or we can't debug it at
> all.

Well, I really tried hard to produce something, but failed so far, if I had
more time I would try a serial console hoping that it survives long enough to
show at least _something_.
The only thing I ever could see was the BUG in page-alloc thing from the
beginning of this thread.

Regards,
Stephan

