Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266310AbTBPLMV>; Sun, 16 Feb 2003 06:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266320AbTBPLMV>; Sun, 16 Feb 2003 06:12:21 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:40324 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S266310AbTBPLMU>; Sun, 16 Feb 2003 06:12:20 -0500
From: David Woodhouse <dwmw2@infradead.org>
To: John Bradford <john@grabjohn.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lm@bitmover.com,
       arashi@yomerashi.yi.org, linux-kernel@vger.kernel.org
In-Reply-To: <200302161108.h1GB8t8m000317@darkstar.example.net>
References: <200302161108.h1GB8t8m000317@darkstar.example.net>
Organization: 
Message-Id: <1045394526.2068.52.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 16 Feb 2003 11:22:06 +0000
Subject: Re: openbkweb-0.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-02-16 at 11:08, John Bradford wrote:
> I just wanted to confirm that bk-commit-head is actually:
> 
> 1. Complete

It should be complete -- but bear in mind that you may receive the mails
in a different order to the order in which they were sent, so just
applying them from a mail filter isn't necessarily sensible.

Also note that the dates on them are the date of the changeset itself,
not the date of application to Linus' tree (or indeed the date of the
cron job which creates the mail).

> 2. Realtime

Almost -- it's run from an hourly cron job, which is more 'real time'
than Linus actually pushing from his own box to master.kernel.org and
quite enough of a demand on resources already.

It's not done with triggers on Linus' tree because I suspect that would
actually make Linus _wait_ while the mail is generated for every
changeset he's pushing to master.kernel.org. I do it with a cron job
which pulls from Linus' tree to another, and I don't do it with triggers
in my own tree because I suspect that would keep Linus' tree locked
while it generated the mails too. I do need to investigate possible
improvements to the way it's generated, though.

Suggestions welcome, preferably in 'diff -u' form. 

	cvs -d :pserver:anoncvs@cvs.infradead.org:/home/cvs co bkexport
	(password anoncvs)

-- 
dwmw2

