Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131527AbQKBQXk>; Thu, 2 Nov 2000 11:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132224AbQKBQXa>; Thu, 2 Nov 2000 11:23:30 -0500
Received: from c90610-a.alton1.il.home.com ([24.11.42.157]:64271 "EHLO
	www.linuxnet") by vger.kernel.org with ESMTP id <S131527AbQKBQXM>;
	Thu, 2 Nov 2000 11:23:12 -0500
Date: Thu, 2 Nov 2000 10:22:22 -0600 (CST)
From: matthew <matthew@mattshouse.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Christoph Rohland <cr@sap.com>,
        Jonathan George <Jonathan.George@trcinc.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-test10 Sluggish After Load
In-Reply-To: <Pine.LNX.4.21.0011021152310.15168-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0011021016120.12598-100000@matthew.linuxnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2000, Rik van Riel wrote:

> > > Of course, this also depends on the amount of people willing
> > > to test out new VM patches and/or help with development.
> > 
> > As you know I am doing regular thrash tests and I am willing to do
> > this further. I would hate to see a customer go down because his
> > machine becomes unusable. IMHO we should try to fix this during 2.4.
> 
> Agreed. Also, we don't have to have the thrashing control
> be too friendly, as long as it is effective and simple ;)


Here's an update.  I never lost control of the machine, so after about 24
hours I decided to try to fix it without the use of the Big Red
Switch.  There were still > 1000 connections showing, and pstools were
unresponsive, so I did:

ls /proc > killscript
added "kill -9" to the beginning and "\" to the end of each line,
ran it as the database user.  It worked pretty well.  After about 5
minutes it killed all of the oracle processes and the machine appeared to
have returned to normal.  I've since installed Oracle 81610 and everything
looks good.

Matthew


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
