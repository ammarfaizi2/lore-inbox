Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261878AbSJDOua>; Fri, 4 Oct 2002 10:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261859AbSJDOuV>; Fri, 4 Oct 2002 10:50:21 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:7083 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261878AbSJDOoa>;
	Fri, 4 Oct 2002 10:44:30 -0400
Importance: Normal
Sensitivity: 
Subject: Re: [PATCH] EVMS core 2/4: evms.h
To: "Kevin M Corry" <corryk@us.ibm.com>
Cc: Robert Varga <nite@hq.alert.sk>, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFA9EC13A7.01869764-ON85256C48.00510A87@pok.ibm.com>
From: "Mark Peloquin" <peloquin@us.ibm.com>
Date: Fri, 4 Oct 2002 09:56:11 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11  |July 29, 2002) at
 10/04/2002 10:49:54 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/04/2002 at 9:03 AM, Kevin Corry wrote:
> > <snip...>
> >
> > > Possibly shortened to:
> > >
> > > static inline int list_member(struct list_head *member)
> > > {
> > >     return member->next && member->prev;
> > > }
> > >
> > > Faster, and (at least to me) it looks more obvious.
> >
> > Yes, this may be shorter. However with this change
> > the return type would also need to be changed to
> > portable across archs.

> What would the return type have to be?

Ok, I was (incorrectly) thinking this would return
a *list_head, but after waking up a bit more I see
the "&&" which should return a int.

So I agree Robert's improvement is fine!

Mark


