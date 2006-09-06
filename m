Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWIFA1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWIFA1c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 20:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWIFA1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 20:27:32 -0400
Received: from web36609.mail.mud.yahoo.com ([209.191.85.26]:11931 "HELO
	web36609.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750792AbWIFA1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 20:27:31 -0400
Message-ID: <20060906002730.23586.qmail@web36609.mail.mud.yahoo.com>
X-RocketYMMF: rancidfat
Date: Tue, 5 Sep 2006 17:27:30 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
To: David Madore <david.madore@ens.fr>,
       Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060905212643.GA13613@clipper.ens.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- David Madore <david.madore@ens.fr> wrote:

> As we all know, capabilities under Linux are
> currently crippled to the
> point of being useless.

The current work in progress to support
capability set on files will address this
longstanding issue.

> ...

> On top of the
> "additional" capabilities
> that lead up to root, it also adds "regular"
> capabilities which all
> processes have by default and which can be removed
> from specifically
> untrusted programs.

Not a bad idea, but the notion of underprivileged
processes has been tried before. The capability
mechanism is explicitly designed to provide for
the seperation and management of privilege and
taking it in the "other" direction requires
a rethinking of the inheritance mechanism.
I understand that today's scheme that does not
do inheritance has problems, but that should
soon be resolved.

> All the gory details as to what it does are
> explained on this page:
> <URL:
>
http://www.madore.org/~david/linux/newcaps/newcaps.html

A fine page, BTW. Thank you.
 
> In short: currently (i.e., prior to applying this
> patch), Linux has
> capabilities, but they are (deliberately) crippled,

The crippling is not deliberate. It is
unfortunate and represents a number of complex
issues that are being resolved. Finally.

> ...  Furthermore, whereas the
> current Linux
> capabilities are only "additional" capabilities
> (meaning that normal,
> non-root, processes, have none, and adding
> capabilities leads up to
> root), the patch also suggests (and, to some extent,
> implements) a new
> bunch of "regular" capabilites, which are present on
> all normal
> processes and can be removed so as to provide some
> measure of
> fault-containment for partially untrusted or
> potentially buggy
> programs (thus, these new capabilities can be said
> to lead down).

Again, the capability scheme is intended to
address the omnipotent userid problem. It pulls
the userid and privilege apart. It also provides
a more granular privilege. But it does not change
what operations require privilege. That is left
to wiser minds.

> ...
> 
> I'd be glad if some people could review this and
> check my reasoning
> attempting to prove that it won't open any security
> holes (or, on the
> contrary, exhibit some).

The fundimental flaw in your reasoning is
the assumption that linux will never have
capability inheritence.

> Comments are welcome,

You did say so!


Casey Schaufler
casey@schaufler-ca.com
