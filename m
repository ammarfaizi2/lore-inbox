Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbTJTOI0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 10:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbTJTOI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 10:08:26 -0400
Received: from mcomail04.maxtor.com ([134.6.76.13]:33291 "EHLO
	mcomail04.maxtor.com") by vger.kernel.org with ESMTP
	id S262580AbTJTOIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 10:08:24 -0400
Message-ID: <785F348679A4D5119A0C009027DE33C105CDB307@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@Maxtor.com>
To: "'Rogier Wolff'" <R.E.Wolff@BitWizard.nl>
Cc: "''Norman Diamond ' '" <ndiamond@wta.att.ne.jp>,
       "''Hans Reiser ' '" <reiser@namesys.com>,
       "''Wes Janzen ' '" <superchkn@sbcglobal.net>,
       "''John Bradford ' '" <john@grabjohn.com>,
       "''linux-kernel@vger.kernel.org ' '" <linux-kernel@vger.kernel.org>,
       "''nikita@namesys.com ' '" <nikita@namesys.com>,
       "''Pavel Machek ' '" <pavel@ucw.cz>,
       "''Justin Cormack ' '" <justin@street-vision.com>,
       "''Russell King ' '" <rmk+lkml@arm.linux.org.uk>,
       "''Vitaly Fertman ' '" <vitaly@namesys.com>,
       "''Krzysztof Halasa ' '" <khc@pm.waw.pl>
Subject: RE: Blockbusting news, results are in
Date: Mon, 20 Oct 2003 08:08:22 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
>
> We're getting annoyed at WD because they are selling WD800 drives 
> (80G) with 2, 4, 6 and 8 heads(*). So when we order a replacement
> WD800 for spare parts for a broken one, we might end up with a
> different generation drive which is useless for the "part exchange"
> project....
> 
> (*) they probably don't sell the full complement... yet.

With "today's generation" of ATA drives, WD and Maxtor stop at 3 platters,
and Seagate stops at a 2-platter design.

Everyone wants to make a 4-platter drive, but for their rather small
volumes, most people find it isn't cost effective.

> You're assuming that a head-switch is faster than a 
> track-to-track seek. Apparently that is no longer true.
> We've seen drives that "scan" a whole platter before
> switching heads. We've seen drives that do this on a 
> per-region basis. 

Track-to-track seeks are faster than headswitches because you don't have to
worry about radial comb imbalance (head A is only guaranteed to be within
some tolerance of head B, this creates your 'skew').

Most vendors these days have a "modified horizontal format" which does some
small number of cylinders (16?) then a headswitch, so that they slowly walk
inward.

Drives that walk the entire platter then headswitch haven't existed for
years I'm quite sure, at least not in modern ATA drives.  Headswitches after
each zone would possibly make sense, but it can make it noticably more
complicated to estimate the time for a seek, which is the key to good
performance.  (e.g. your "local area" IO becomes IO across potentially
thousands of cylinders)

> How about: "Opening it up and having a peek?" :-) That certainly
> works. But most vendors don't let me do that before I buy.  :-)

Before you buy? um, no =P

--eric
