Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265303AbTGCBAl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 21:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265398AbTGCBAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 21:00:41 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:48115 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S265303AbTGCBAj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 21:00:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: PTY DOS vulnerability?
Date: Wed, 2 Jul 2003 20:14:36 -0500
X-Mailer: KMail [version 1.2]
Cc: Fredrik Tolf <fredrik@dolda2000.cjb.net>, linux-kernel@vger.kernel.org
References: <200306301613.11711.fredrik@dolda2000.cjb.net> <03070106574900.01125@tabby> <20030701195323.GA15483@hh.idb.hist.no>
In-Reply-To: <20030701195323.GA15483@hh.idb.hist.no>
MIME-Version: 1.0
Message-Id: <03070220143600.04348@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 July 2003 14:53, Helge Hafting wrote:
> On Tue, Jul 01, 2003 at 06:57:49AM -0500, Jesse Pollard wrote:
> > One problem is that ptys are not just "used by the user". Every terminal
> > window opened uses a pty. As does a network connection.
> >
> > As does "expect" - which is less visible to the user since it is intended
> > to be invisible.
> >
> > The real question is "how many PTYs should a single user have?"
> > Which then prompts the question "How many concurrent users should there
> > be?"
> >
> > second, just providing a user limit doesn't prevent a denial of service..
> > Just have more connections than ptys and you are in the same situation.
>
> Isn't this something a improved sshd could do?  I.e. if the
> connection using up the last (or one of the last) pty's logs
> in as non-root - just kill it.

and how is it to determine that it is the last?

try two and die if the second fails???

at least one system just creates more ptys...
