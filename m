Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293191AbSCEXXY>; Tue, 5 Mar 2002 18:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293155AbSCEXXO>; Tue, 5 Mar 2002 18:23:14 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:26887 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S293163AbSCEXXD>; Tue, 5 Mar 2002 18:23:03 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 5 Mar 2002 15:26:31 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Hubertus Franke <frankeh@watson.ibm.com>
cc: Rusty Russell <rusty@rustcorp.com.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
In-Reply-To: <20020305231747.5F95B3FE06@smtp.linux.ibm.com>
Message-ID: <Pine.LNX.4.44.0203051525460.1475-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2002, Hubertus Franke wrote:

> On Tuesday 05 March 2002 05:39 pm, Davide Libenzi wrote:
> > On Tue, 5 Mar 2002, Rusty Russell wrote:
> > > +	pos_in_page = ((unsigned long)uaddr) % PAGE_SIZE;
> > > +
> > > +	/* Must be "naturally" aligned, and not on page boundary. */
> > > +	if ((pos_in_page % __alignof__(atomic_t)) != 0
> > > +	    || pos_in_page + sizeof(atomic_t) > PAGE_SIZE)
> > > +		return -EINVAL;
> >
> > How can this :
> >
> > 	(pos_in_page % __alignof__(atomic_t)) != 0
> >
> > to be false, and together this :
> >
> > 	pos_in_page + sizeof(atomic_t) > PAGE_SIZE
> >
> > to be true ?
> > This is enough :
> >
> > 	if ((pos_in_page % __alignof__(atomic_t)) != 0)
> >
> >
>
> I believe not all machine have  alignof  == sizeof

Yes but this is always true   alignof >= sizeof




- Davide


