Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264460AbTEJRx2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 13:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264461AbTEJRx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 13:53:28 -0400
Received: from host132.googgun.cust.cyberus.ca ([209.195.125.132]:43437 "EHLO
	marauder.googgun.com") by vger.kernel.org with ESMTP
	id S264460AbTEJRx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 13:53:27 -0400
Date: Sat, 10 May 2003 14:03:57 -0400 (EDT)
From: Ahmed Masud <masud@googgun.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jesse Pollard <jesse@cats-chateau.net>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Terje Eggestad <terje.eggestad@scali.com>
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <20030510175625.B28820@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.33.0305101359570.24799-100000@marauder.googgun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 10 May 2003, Arjan van de Ven wrote:

> On Sat, May 10, 2003 at 01:51:07PM -0400, Ahmed Masud wrote:
> > That becomes a bit more difficult to time, because the attacker doesn't
> > know when the system call will actually perform its own copy_from_user vs.
> > return vs. the audit's copy_from_user, If the correct upper threshold for
> > each system call is picked timing attacks can be made alot harder.
>
> no it's not. just make sure the page with the filename is paged
> out, and use mincore to poll for the pagefault ;)
> And with unlink you can observe the results as well (think dnotify) so you
> can intervene before the second audit copy
>
> still not secure, now you copy 3 times so all I need to do is flip
> data twice ;)
>

Very interesting indeed, good thing i am not auditing parameters ;)
hehe. The only thing i was tracking was whether the particular system call
was allowed or denied to the user, due to an ACL and because that doesn't
rely on the user-land data i am not particulary effected.

I will setup some parametric auditing on pointer data and attack the
environment using your technique above to see if something can be done
about it.

(heheh there goes the afternoon!)

Cheers,

Ahmed.

