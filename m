Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289210AbSBJCjz>; Sat, 9 Feb 2002 21:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289211AbSBJCjo>; Sat, 9 Feb 2002 21:39:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34322 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289210AbSBJCjc>;
	Sat, 9 Feb 2002 21:39:32 -0500
Message-ID: <3C65DD61.3AFF0EA0@mandrakesoft.com>
Date: Sat, 09 Feb 2002 21:39:29 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [bk patch] Make cardbus compile in -pre4
In-Reply-To: <Pine.LNX.4.33.0202081824070.25114-100000@segfault.osdlab.org> <20020208203931.X15496@lynx.turbolabs.com> <3C649F4F.7E190D26@mandrakesoft.com> <20020209002920.Z15496@lynx.turbolabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> The problem is that (AFAIK) bk pull does not let Linus pick-and-choose
> which patches he wants to accept as easily as importing them at the time
> he reads each email.  It basically assumes that he wants everything that
> is in the repository he is pulling from.

Yes and no.  'bk pull' does indeed make the presumption that Linus will
like or dislike the entire patchset being pulled.  That's why one wants
to separate different types of changes into different BK trees.  For
example you might have a BK clone with just ext2 fixes, then a BK clone
off of your ext2-fixes tree which contains your ext2 resize work.  Or,
if you wanted those separate and not parent-child, you could clone both
ext2-fixes and ext2-resize trees off of Linus's standard tree.

But I disagree a bit.  Basically, if you organize the trees from which
Linus would do a 'bk pull' then he can easily (a) 'bk unpull' if he
dislikes everything, and (b) easily inspect each changeset.

I personally plan on sending Linus GNU patches simply for his review, as
I did with the recent swap_device cleanup patch, as well as giving him a
location for doing the 'bk pull'.  In that specific case, there was a
tree http://gkernel.bkbits.net/vm-2.5 which contained nothing but that
one change.

Used in this sense, 'bk pull' is really the primary merging tool, and
e-mail is simply a reminder to Linus that he should do a pull.

	Jeff



-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
