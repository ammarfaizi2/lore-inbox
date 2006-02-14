Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030515AbWBNIYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030515AbWBNIYs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 03:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030517AbWBNIYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 03:24:48 -0500
Received: from [213.91.10.50] ([213.91.10.50]:45514 "EHLO zone4.gcu-squad.org")
	by vger.kernel.org with ESMTP id S1030515AbWBNIYr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 03:24:47 -0500
Date: Tue, 14 Feb 2006 09:18:39 +0100 (CET)
To: quilt-dev@nongnu.org
Subject: Re: [Quilt-dev] Quilt 0.43 has been released! [SERIOUS BUG]
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <RyUOlVAg.1139905119.2584600.khali@localhost>
In-Reply-To: <200602140510.54960.agruen@suse.de>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       Yasushi SHOJI <yashi@atmark-techno.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-2.1.2 (zone4.gcu-squad.org [127.0.0.1]); Tue, 14 Feb 2006 09:18:40 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

On 2006-02-14, Andreas Gruenbacher wrote:
> On Tuesday 14 February 2006 04:25, Peter Williams wrote:
> > The problem arises when pushing a patch that has errors in it (due to
> > changes in the previous patches in the series) and needs the -f flag to
> > force the push.  What's happening is that the reverse of the errors is
> > being applied to the "pre patch" file in the .pc directory.  Then when
> > you pop this patch it returns the file to a state with the reverse of
> > the errors applied to it.
>
> Found and fixed. It's a missed rollback_patch on one of the two branches of
> the code that checks if a patch can be reverse applied. This case
> apparently doesn't trigger as easily as it seems, or else we would have
> found it sooner. Still quite bad.

I probably encountered it the other day, but as I couldn't explain what
was happening, I mistakenly concluded to a user error and started again
from a fresh tree. Or maybe it was really a user error after all.

I was about to suggest that we add a test in the quilt test suite, but I
see you did already - good!

> Shall we wait until the translations are up-to-date again, or release
> 0.44 immediately?

I'd say:
* Fix the temporary file leak in the mail command I have been reporting a
few days ago - unless it's there on purpose.
* Update the translations. I'll take care of French this evening
(GMT+01).
* Let people (including me) do a little testing. If nothing else, running
the test suite on a few different systems can't hurt.
* Release.

We can be done by tomorrow if Yashi can handle the Japanese translation
fast. If Yashi is too busy I guess we'll have to release anyway...

Thanks,
--
Jean Delvare
