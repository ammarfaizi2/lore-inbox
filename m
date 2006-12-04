Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759111AbWLDRnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759111AbWLDRnM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 12:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759125AbWLDRnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 12:43:12 -0500
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:61352 "EHLO
	ms-smtp-03.texas.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759029AbWLDRnL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 12:43:11 -0500
Message-Id: <200612041742.kB4HgpfA005705@ms-smtp-03.texas.rr.com>
Reply-To: <Aucoin@Houston.RR.com>
From: "Aucoin" <Aucoin@Houston.RR.com>
To: "'David Lang'" <dlang@digitalinsight.com>,
       "'Kyle Moffett'" <mrmacman_g4@mac.com>
Cc: "'Tim Schmielau'" <tim@physik3.uni-rostock.de>,
       "'Andrew Morton'" <akpm@osdl.org>, <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>, <clameter@sgi.com>
Subject: RE: la la la la ... swappiness
Date: Mon, 4 Dec 2006 11:42:50 -0600
Organization: home
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-reply-to: <Pine.LNX.4.63.0612040733390.6970@qynat.qvtvafvgr.pbz>
Thread-Index: AccXvovMUwQQIk8DQ5muG5RQQqpFJwAC79ww
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: David Lang [mailto:dlang@digitalinsight.com]
> I think that I am seeing two seperate issues here that are getting mixed
> up.

Fair enough.

> however the real problem that Aucoin is running into is patching process
> (tar, etc) kicks off the system is choosing to use it's

First name Louis, yes but we haven't resorted to echoing 3 in a loop at
drop_caches yet.

> from the documentation on swappiness it seems like setting it to 0 would
> do what he wants

That's what I thought, but some responses would seem to indicate that these
two "types" of memory are completely independent of each other and
swappiness has no impact on the type that is currently annoying me. It just
doesn't seem like a fair way to run a kernel when you have a dial dial to
control swappiness but then there's this rogue memory consumption that lives
outside the control of the swappiness dial and you end up swapping anyway.

> this is the same type of problem that people run into with the nightly
> updatedb

I would imagine so, yes. But take that example and instead of programs going
in active over night substitute programs that go inactive for only a few
seconds ... swap thrash, oom-killer, game over.

> IIRC there is a flag that can be passed to the open that tells the system
> that

I'll check into it.


