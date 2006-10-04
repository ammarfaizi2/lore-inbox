Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbWJDXfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWJDXfF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 19:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWJDXfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 19:35:04 -0400
Received: from THUNK.ORG ([69.25.196.29]:10677 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751230AbWJDXfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 19:35:00 -0400
Date: Wed, 4 Oct 2006 19:29:39 -0400
From: Theodore Tso <tytso@mit.edu>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "John W. Linville" <linville@tuxdriver.com>,
       Jeff Garzik <jeff@garzik.org>, Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061004232939.GA19647@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Jean Tourrilhes <jt@hpl.hp.com>, Linus Torvalds <torvalds@osdl.org>,
	"John W. Linville" <linville@tuxdriver.com>,
	Jeff Garzik <jeff@garzik.org>, Lee Revell <rlrevell@joe-job.com>,
	Alessandro Suardi <alessandro.suardi@gmail.com>,
	Norbert Preining <preining@logic.at>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, johannes@sipsolutions.net
References: <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org> <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org> <20061003183849.GA17635@bougret.hpl.hp.com> <4522B311.7070905@garzik.org> <20061003214038.GE23912@tuxdriver.com> <Pine.LNX.4.64.0610031454420.3952@g5.osdl.org> <20061004181032.GA4272@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041133040.3952@g5.osdl.org> <20061004185903.GA4386@bougret.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061004185903.GA4386@bougret.hpl.hp.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 11:59:03AM -0700, Jean Tourrilhes wrote:
> 	That's exactly what it hinges on. What is your criteria for
> removing the old ESSID API. My understanding was 6 months.

Just to make it clear.  The current practice is that 6 months is the
_minimum_, after an extensive discussion on LKML and an understanding
that costs of supporting both the old and the new interface outweighs
the cost and pain to the user community of removing the old interface.
Then after there is an agrement on how long the deprecation window
will be (and sometimes it is negotiated to be longer than six months),
it is documented in

	 /usr/src/linux/Documentation/feature-removal-schedule.txt

But it's never been the case that after six months, we can remove a
feature just because we feel like it, or it's slightly more convenient
to programmers at the cost of imposing pain on users, or at the cost
of discouraging users from testing bleeding edge kernels.

As others have pointed out, we have maintained old stat system call
interfaces for over a ***decade***.  

So perhaps that's something to keep in mind as we start considering
with the next generation wireless interface looks like, and whether it
is sufficiently well defined and has enough forwards and backwards
compatibility, both at the driver level and at the userspace level, so
that we can avoid these sorts of problems going forward.

Regards,

						- Ted

P.S.  Because of all of these changing interfaces, I *still* haven't
been able to get wpa_supplicant working with LEAP so I can get
wireless access to in IBM offices using my ipw3945 driver.  I've
tried, and failed.  Sigh, I guess I'm not smart enough....

