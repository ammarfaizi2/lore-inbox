Return-Path: <linux-kernel-owner+w=401wt.eu-S936178AbWLIMjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936178AbWLIMjf (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 07:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936996AbWLIMjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 07:39:35 -0500
Received: from [139.30.44.16] ([139.30.44.16]:25661 "EHLO
	gockel.physik3.uni-rostock.de" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S936178AbWLIMje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 07:39:34 -0500
Date: Sat, 9 Dec 2006 13:39:33 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: why are some of my patches being credited to other "authors"?
In-Reply-To: <Pine.LNX.4.64.0612090656140.13654@localhost.localdomain>
Message-ID: <Pine.LNX.4.63.0612091327540.24913@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.64.0612090515480.12992@localhost.localdomain>
 <1165663793.1103.127.camel@localhost.localdomain>
 <Pine.LNX.4.64.0612090656140.13654@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> but it still leaves an open issue -- once one submits a patch, is there 
> *any* official feedback that one can look for to see if it's been 
> accepted/rejected/dropped on the floor/whatever?

You can regularely pull Linus' tree (or the tree of the maintainer you 
sent your patch) and see whether your patches still apply cleanly. 
Whenever they cause a reject, they need your attention: either they were 
applied, or they got out of date because something else changed.
(akpm also sends out automatic notification emails for patches in the -mm 
tree based on a similar method.)

> but given that i'm trying to follow the kernel guidelines and keep
> each submission as a logically-related chunk, in many cases, i have to
> wait for one patch to be applied before i can submit the next one.
> and, at the moment, there's no way of knowing what's going on.

Well, you can send out a patch series:
  [patch 01/02] Prepare foo for blah
  [patch 02/02] Apply blah to foo
Ideally you would finish the patch description for patch 02 with something 
like

---
This patch depends on [patch 01/02] Prepare foo for blah

But usually people will assume they have to apply the patches in order 
even without you explicitly telling them.
Unless you are keen on particular feedback about patch 01 before doing 
much work on patch 02, this should work out well.

Tim
