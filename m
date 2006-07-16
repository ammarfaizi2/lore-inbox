Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWGPSO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWGPSO2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 14:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWGPSO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 14:14:28 -0400
Received: from thunk.org ([69.25.196.29]:3219 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751146AbWGPSO0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 14:14:26 -0400
Date: Sun, 16 Jul 2006 14:14:31 -0400
From: Theodore Tso <tytso@mit.edu>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiserFS?
Message-ID: <20060716181431.GA27306@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	linux-kernel@vger.kernel.org
References: <20060716161631.GA29437@httrack.com> <20060716162831.GB22562@zeus.uziel.local> <20060716165648.GB6643@thunk.org> <20060716174636.GA3615@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060716174636.GA3615@gallifrey>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2006 at 06:46:37PM +0100, Dr. David Alan Gilbert wrote:
> That leads me to ask what level of testing is performed on each
> filesystem - are there filesystem torture tests that are getting
> run by someone (who?) on various filesystems (preferably on large
> TB sized ones, preferably with simulated failures and resets)?
> The discussions on Ext4 a few weeks ago made me think that the
> thing I'd value more than anything else would be a damn good
> test regime.

As far as I know ext2/3 is the only filesystem with a fsck tool that
has a regression test suite.  It's always amazed me that filesystem
consistency checkers and repair tools get so little attenion by most
filesystem developers.

As far as random torture testing, Pavel has written a random test tool
that punches random errors into random blocks of a filesystem, and
that was used to uncover a couple of cases that e2fsprogs didn't
handle cleanly.  Those were reported to me, and I fixed them, and the
edge cases were encorprated into the regression test suite.

IIRC it came up in discussion a few weeks ago one LKML or
linux-fsdevel (I can't remember which), and I believe either someone
from XFS or Reiser team was going to take Pavel's torture tester and
adapt it do some robustifying of their filesystem's repair
capabilities.

Finally, the good folks at the Stanford Metacompilation group did some
very interesting work to find bugs in three common Linux filesystems:

	http://keeda.stanford.edu/~junfeng/papers/osdi04/osdi04.html

Regards,

						- Ted
