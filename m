Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265177AbTFRMGp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 08:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265178AbTFRMF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 08:05:27 -0400
Received: from pointblue.com.pl ([62.89.73.6]:30222 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S265177AbTFRMFU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 08:05:20 -0400
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Organization: K4 Labs
To: Gerhard Mack <gmack@innerfire.net>, James Simmons <jsimmons@infradead.org>
Subject: Re: Linux 2.5.71 - random console corruption
Date: Wed, 18 Jun 2003 12:56:24 +0100
User-Agent: KMail/1.5.2
Cc: Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0306172149150.8889-100000@innerfire.net>
In-Reply-To: <Pine.LNX.4.44.0306172149150.8889-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200306181256.30735@gjs>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 18 of June 2003 02:50, Gerhard Mack wrote:
> On Tue, 17 Jun 2003, James Simmons wrote:
> > > > For userland<->kernel transactions we have the console_semaphore to
> > > > protect us. It is also used for console_callback. The
> > > > console_semaphore is not used internally to protect global variables
> > > > :-( To do this properly would take quite a bit of work.
> > >
> > > It looks like all these globals need a lock -- they can race on SMP or
> > > with kernel preemption.
> > >
> > > Is it really going to be that hard to wrap a lock around their access,
> > > because I think this is going to bite SMP users.
> >
> > For things like fg_console and currcon it will be. Those variables are
> > used everyway like mad. That is a whole lot of locks. I doubt this issue
> > will be solved until 2.7.X.
>
> Interestingly enough it's not console switching that does it.. it's
> scrolling also as I mentioned before it's not just with preempt enabled.
>
> I wonder if theres another problem somewhere?
I've got simmilar problem with 2.5.72, sometimes keyboard stops to respond (in 
X windows). Mouse is usefull, all i have to do is restart Xwindows and 
everything is running well.

- --
Grzegorz Jaskiewicz
K4 Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+8FNtqu082fCQYIgRAkjyAJ9tWkOANrS9jEWo9XytzhM1k9bNEQCfXRzd
3IgRlKPiiJUt3z0gf791bUA=
=Z8VM
-----END PGP SIGNATURE-----

