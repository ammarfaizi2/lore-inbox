Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263142AbTJZN7g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 08:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263144AbTJZN7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 08:59:36 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:8383 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S263142AbTJZN73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 08:59:29 -0500
To: "Norman Diamond" <ndiamond@wta.att.ne.jp>
Cc: "John Bradford" <john@grabjohn.com>,
       "Mudama, Eric" <eric_mudama@Maxtor.com>,
       "'Hans Reiser '" <reiser@namesys.com>,
       "'Wes Janzen '" <superchkn@sbcglobal.net>,
       "'Rogier Wolff '" <R.E.Wolff@BitWizard.nl>,
       <linux-kernel@vger.kernel.org>, <nikita@namesys.com>,
       "'Pavel Machek '" <pavel@ucw.cz>,
       "'Justin Cormack '" <justin@street-vision.com>,
       "'Vitaly Fertman '" <vitaly@namesys.com>
Subject: Re: Blockbusting news, results get worse
References: <334101c39b94$268a0370$24ee4ca5@DIAMONDLX60>
	<200310261039.h9QAdniV000310@81-2-122-30.bradfords.org.uk>
	<358a01c39bb5$c651c7a0$24ee4ca5@DIAMONDLX60>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 26 Oct 2003 14:59:28 +0100
In-Reply-To: <358a01c39bb5$c651c7a0$24ee4ca5@DIAMONDLX60>
Message-ID: <m37k2s9k1r.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Norman Diamond" <ndiamond@wta.att.ne.jp> writes:

> By the way some participants in this thread have argued that the block
> should not be replaced by zeroes or random garbage without notice.  I fully
> agree.  The block should be replaced by zeroes or random garbage WITH
> notice.

Right. The correct way of sending such a notice is returning I/O error
on read. It's standard and applications support it for years (of course
we can - and currently do - log the error as well).

>  From the point of view of logging it in the system log, it is
> enough to log it once, it doesn't have to be logged over and over again.

Storing a log entry in system log doesn't tell applications there is
a problem. It's simply unacceptable.
Relocating on write (at filesystem level) - sure, it would be helpful
(possibly as a compile-time option - most IDE drives and things like
RAM disks don't need it).
-- 
Krzysztof Halasa, B*FH
