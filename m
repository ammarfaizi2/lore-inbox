Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422716AbWJXWRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422716AbWJXWRN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 18:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422712AbWJXWRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 18:17:12 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:5542 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1422716AbWJXWRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 18:17:12 -0400
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
In-Reply-To: <200610242216.05949.rjw@sisk.pl>
References: <1161576735.3466.7.camel@nigel.suspend2.net>
	 <200610242216.05949.rjw@sisk.pl>
Content-Type: text/plain
Date: Wed, 25 Oct 2006 08:17:11 +1000
Message-Id: <1161728231.22729.24.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2006-10-24 at 22:16 +0200, Rafael J. Wysocki wrote:
> On Monday, 23 October 2006 06:12, Nigel Cunningham wrote:
> > XFS can continue to submit I/O from a timer routine, even after
> > freezeable kernel and userspace threads are frozen. This doesn't seem to
> > be an issue for current swsusp code, but is definitely an issue for
> > Suspend2, where the pages being written could be overwritten by
> > Suspend2's atomic copy.
> >     
> > We can address this issue by freezing bdevs after stopping userspace
> > threads, and thawing them prior to thawing userspace.
> 
> Okay, it turns out we'll probably need this, so a couple of comments follow.

Ack. Revised version will come when I find/make the time to do it :)
Feel free to prod :>

Nigel

