Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbTETWxa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 18:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbTETWxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 18:53:30 -0400
Received: from mail.casabyte.com ([209.63.254.226]:56581 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP id S261428AbTETWxO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 18:53:14 -0400
From: "Robert White" <rwhite@casabyte.com>
To: <root@chaos.analogic.com>
Cc: "Helge Hafting" <helgehaf@aitel.hist.no>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
Subject: RE: recursive spinlocks. Shoot.
Date: Tue, 20 May 2003 16:06:08 -0700
Message-ID: <PEEPIDHAKMCGHDBJLHKGAEGHCMAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.53.0305201709440.1074@chaos>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Richard B. Johnson [mailto:root@chaos.analogic.com]

> The lock must guarantee that recursion is not allowed. Or to put
> it more bluntly, the lock must result in a single thread of execution
> through the locked object.

Where the HECK do you get that load of bull?  The one requirement of a
MUTUAL EXCLUSION PRIMITIVE (a.k.a. mutex, a.k.a. lock) is *MUTUAL*
EXCLUSIVITY.

Nothing else.  Lets look at the words:

Mutual - "directed by *each* toward the *other* or *others*" (e.g. not self,
duh) {all other definitions talk about group insurance, which applies too
8-)

Exclusion -> exclude -> "To prevent or restrict entrance" (etc.) "to bar
from participation"

So, a mutex erects a "bar to/from participation" "directed by each (holder)
to other (would be holder(s))".

There is no concept of "Self Exclusion" in a lock (mutex et. al.) so
recursion, by definition, is (or should be) permitted.

All else is unfounded blither.

The fact is, that it is easier to write locks that will self dead-lock and
lazy people, acting in the name of expediency, decided that somehow, such
locks were "better" because they didn't want to expend the effort to make
them correct.  Still others then try to stand on lazy precedent as if it is
somehow cannon.

The only place/way you can argue this is if the constituent operations "X"
within a larger body of code Alpha are not considered part of Alpha (re, the
previous Alpha is composed of X and others example).  But that is like
yelling "I locked it, so my arm, which is not all of me, should not be
allowed to use it because my arm is not me..."

>From the standpoint of purely logical analysis, this is a little esoteric...
and obviously specious tripe.

Rob.

