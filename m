Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbTJSRge (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 13:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbTJSRge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 13:36:34 -0400
Received: from mcomail03.maxtor.com ([134.6.76.14]:52237 "EHLO
	mcomail03.maxtor.com") by vger.kernel.org with ESMTP
	id S261936AbTJSRgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 13:36:33 -0400
Message-ID: <785F348679A4D5119A0C009027DE33C105CDB301@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@Maxtor.com>
To: "'Hans Reiser '" <reiser@namesys.com>
Cc: "''Norman Diamond ' '" <ndiamond@wta.att.ne.jp>,
       "''Wes Janzen ' '" <superchkn@sbcglobal.net>,
       "''Rogier Wolff ' '" <R.E.Wolff@BitWizard.nl>,
       "''John Bradford ' '" <john@grabjohn.com>,
       "''linux-kernel@vger.kernel.org ' '" <linux-kernel@vger.kernel.org>,
       "''nikita@namesys.com ' '" <nikita@namesys.com>,
       "''Pavel Machek ' '" <pavel@ucw.cz>,
       "''Justin Cormack ' '" <justin@street-vision.com>,
       "''Russell King ' '" <rmk+lkml@arm.linux.org.uk>,
       "''Vitaly Fertman ' '" <vitaly@namesys.com>,
       "''Krzysztof Halasa ' '" <khc@pm.waw.pl>
Subject: RE: Blockbusting news, results are in
Date: Sun, 19 Oct 2003 11:36:31 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Eric, is it true what we tell users, that if a drive can't remap
> a bad block it has probably used up all its spares, and that in
> turn means that it is wise to buy a new one because the chance of
> experiencing additional data corruption on a drive that has used
> up all its spares is much higher than the average drive?

Not sure about other vendors, but a fatal write on a maxtor means we
couldn't do your write after exhausting all attempts at reallocation,
recertification, etc.  If you ever get this on a drive, either:

1) the drive is unable to reallocate any more blocks because it has run out
of spares

or

2) the drive was attempting those writes under environmental conditions that
it was unable to handle. (extreme shock&vibe, <5C, >55C, etc)

> What are the common sources of data corruption, is one of them
> that the drive head starts bumping the media more and more often
> because a bearing (or something) has started to show signs of wear?

>From my understanding, most returns are due to damaged heads (some small
percent burn up over time) or operational shock "head/media events" where
someone bumped a running drive and the head dug a crater in the media.  Any
particulate contamination can be struck by the heads causing high-fly write
events.  (head bounces up off the media in the middle of a write).  I
haven't heard of bearing wear being a common issue... all drives these days
use fluid bearings.  Early fluid bearings had outgassing issues at high
temperature, but I think those problems were solved by manufacturers long
before the first drives using them hit store shelves.

All in all, they're rather delicate.  I'm amazed they work at all too.

--eric
