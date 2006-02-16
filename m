Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbWBPR6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWBPR6w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 12:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbWBPR6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 12:58:51 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:3799 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932549AbWBPR6u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 12:58:50 -0500
Date: Thu, 16 Feb 2006 11:57:49 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Greg <gkurz@fr.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: Re: (pspace,pid) vs true pid virtualization
Message-ID: <20060216175749.GB11974@sergelap.austin.ibm.com>
References: <20060215145942.GA9274@sergelap.austin.ibm.com> <m11wy4s24i.fsf@ebiederm.dsl.xmission.com> <20060216143030.GA27585@MAIL.13thfloor.at> <20060216153729.GB22358@sergelap.austin.ibm.com> <m1wtfvp6pk.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1wtfvp6pk.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> "Serge E. Hallyn" <serue@us.ibm.com> writes:
> 
> > Quoting Herbert Poetzl (herbert@13thfloor.at):
> >> > - Should a process have some sort of global (on the machine identifier)?
> >> 
> >> this is mandatory, as it is required to kill any process
> >> from the host (admin) context, without entering the pid
> >> space (which would lead to all kind of security issues)
> >
> > Just to be clear: you think there should be cases where pspace x can
> > kill processes in pspace y, but can't enter it?
> >
> > I'm not convinced that grounded in reasonable assumptions...
> 
> Actually I think it is.  The admin should control what is running
> on their box.

Of course.  I meant "grounded in reasonable security assumptions."

If you really are the admin then you will find another way of
"getting into" the pspace.

But really, what does "enter" mean in this case?  If you can see
the processes so as to kill them, is that all you need?  After all
this is distinct from the filesystem namespace - the pids are the
only thing that's distinct.  So the only thing that I can see you
preventing by preventing "entering" the pspace is starting a new
process with a pid valid in the other pspace.

-serge
